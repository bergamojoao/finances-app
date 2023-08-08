import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from 'src/services/prisma.service';
import { BcryptService } from 'src/services/bcrypt.service';
import { UsersService } from 'src/users/users.service';

@Module({
  controllers: [AuthController],
  providers: [
    ConfigService,
    JwtService,
    PrismaService,
    BcryptService,
    UsersService,
    AuthService,
  ],
})
export class AuthModule {}
