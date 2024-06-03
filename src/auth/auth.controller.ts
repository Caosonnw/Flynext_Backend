import {
  Body,
  Controller,
  Headers,
  HttpException,
  HttpStatus,
  Post,
} from '@nestjs/common';
import { ApiExcludeEndpoint, ApiTags } from '@nestjs/swagger';
import { LoginUserDto } from './auth-dto/login-user.dto';
import { SingUpUserDto } from './auth-dto/signup-user-dto';
import { AuthService } from './auth.service';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('sign-up')
  signUp(@Body() SingUpUserDto: SingUpUserDto) {
    return this.authService.signUp(SingUpUserDto);
  }

  @Post('login')
  login(@Body() LoginUserDto: LoginUserDto) {
    return this.authService.login(LoginUserDto);
  }

  @ApiExcludeEndpoint()
  @Post('reset-token')
  async resetToken(@Headers() headers) {
    const token = headers.Authorization?.split(' ')[1];
    console.log(token);
    if (!token) {
      return {
        data: '',
        message: 'Token not provided',
        status: HttpStatus.UNAUTHORIZED,
        date: new Date(),
      };
    }

    try {
      return await this.authService.resetToken(token);
    } catch (error) {
      throw new HttpException(
        'An error occurred while resetting token',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
