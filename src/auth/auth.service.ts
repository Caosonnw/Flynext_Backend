import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { LoginUserDto } from './auth-dto/login-user.dto';
import { SingUpUserDto } from './auth-dto/signup-user-dto';
import * as jwt from 'jsonwebtoken';

@Injectable()
export class AuthService {
  constructor(
    private readonly jwtService: JwtService,
    private prisma: PrismaClient,
  ) {}

  generateRandomString = (length) => {
    let result = '';
    const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
  };

  async signUp(SingUpUserDto: SingUpUserDto) {
    const {
      full_name,
      email,
      password,
      gender,
      date_of_birth,
      nationality,
      cccd,
      address,
      phone,
    } = SingUpUserDto;
    try {
      const user = await this.prisma.users.findUnique({
        where: { email: email },
      });
      if (user) {
        throw new HttpException('User already exists', HttpStatus.BAD_REQUEST);
      }
      const hashedPassword = bcrypt.hashSync(password, 10);
      const formattedDateOfBirth = date_of_birth
        ? new Date(date_of_birth).toISOString()
        : null;
      let newData = {
        full_name,
        email,
        password: hashedPassword,
        gender,
        date_of_birth: formattedDateOfBirth,
        nationality,
        cccd,
        address,
        phone,
        role: 'USER',
        refresh_token: '',
      };

      await this.prisma.users.create({
        data: newData,
      });
      return {
        message: 'Sign up successfully!',
        status: HttpStatus.CREATED,
        date: new Date(),
      };
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'An error occurred during the sign-up process',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async login(loginUserDto: LoginUserDto) {
    const { email, password } = loginUserDto;

    try {
      const user = await this.prisma.users.findUnique({
        where: { email: email },
      });

      if (!user) {
        throw new HttpException('Email is not found!', HttpStatus.NOT_FOUND);
      }

      if (!bcrypt.compareSync(password, user.password)) {
        throw new HttpException(
          'Password is incorrect!',
          HttpStatus.BAD_REQUEST,
        );
      }

      const key = this.generateRandomString(6);
      const payload = { user_id: user.user_id, key };

      const accessToken = this.jwtService.sign(payload, {
        expiresIn: '5m',
        algorithm: 'HS256',
        secret: process.env.JWT_SECRET,
      });

      const refreshToken = this.jwtService.sign(
        { user_id: user.user_id, key },
        {
          expiresIn: '7d',
          algorithm: 'HS256',
          secret: process.env.JWT_SECRET_REFRESH,
        },
      );

      user.refresh_token = refreshToken;

      await this.prisma.users.update({
        data: user,
        where: { user_id: user.user_id },
      });

      return {
        data: accessToken,
        message: 'Login successfully!',
        status: HttpStatus.OK,
        date: new Date(),
      };
    } catch (error) {
      if (error instanceof HttpException) {
        throw error;
      }

      throw new HttpException(
        'An error occurred during the login process',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async resetToken(token: string) {
    console.log(token);
    try {
      let decoded;
      try {
        decoded = await this.jwtService.verifyAsync(token, {
          secret: process.env.JWT_SECRET,
        });
      } catch (error) {
        if (error instanceof jwt.TokenExpiredError) {
          throw new HttpException('TokenExpiredError', HttpStatus.UNAUTHORIZED);
        } else {
          throw new HttpException('Invalid token', HttpStatus.UNAUTHORIZED);
        }
      }

      const getUser = await this.prisma.users.findFirst({
        where: { user_id: decoded.user_id },
      });

      if (!getUser) {
        throw new HttpException('User not found', HttpStatus.UNAUTHORIZED);
      }

      const tokenRef = this.jwtService.decode(getUser.refresh_token);

      if (!tokenRef || !tokenRef.key) {
        throw new HttpException('Invalid token data', HttpStatus.UNAUTHORIZED);
      }

      const isValidRefreshToken = await this.jwtService.verifyAsync(
        getUser.refresh_token,
        {
          secret: process.env.JWT_SECRET_REFRESH,
        },
      );

      if (!isValidRefreshToken) {
        throw new HttpException('Not Authorized', HttpStatus.UNAUTHORIZED);
      }

      // Create a new token
      const tokenNew = this.jwtService.sign({
        user_id: getUser.user_id,
        key: tokenRef.key,
      });
      console.log(tokenNew);
      return {
        data: tokenNew,
        message: 'Token refreshed',
        status: HttpStatus.OK,
        date: new Date(),
      };
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      }

      throw new HttpException(
        error.message || 'An error occurred while refreshing token',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
