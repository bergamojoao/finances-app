import { Module } from '@nestjs/common';
import { GoogleAuthenticationService } from './google-auth.service';
import { GoogleAuthenticationController } from './google-auth.controller';
import { UsersService } from 'src/users/users.service';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from 'src/services/prisma.service';
import { UsersModule } from 'src/users/users.module';
import { BcryptService } from 'src/services/bcrypt.service';
import { HttpModule } from '@nestjs/axios';
import { JwtService } from '@nestjs/jwt';

@Module({
  imports: [UsersModule, HttpModule],
  controllers: [GoogleAuthenticationController],
  providers: [
    ConfigService,
    JwtService,
    PrismaService,
    BcryptService,
    GoogleAuthenticationService,
    UsersService,
  ],
})
export class GoogleAuthenticationModule {}
