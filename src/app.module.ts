import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { JwtStrategy } from './strategy/jwt.strategy';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { AirportsModule } from './airports/airports.module';
import { FlightsModule } from './flights/flights.module';

@Module({
  imports: [ConfigModule.forRoot({ isGlobal: true }), AuthModule, UsersModule, AirportsModule, FlightsModule],
  controllers: [AppController],
  providers: [AppService, JwtStrategy],
})
export class AppModule {}
