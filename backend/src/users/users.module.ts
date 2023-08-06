import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { PrismaService } from 'src/services/prisma.service';
import { BcryptService } from 'src/services/bcrypt.service';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

@Module({
  controllers: [UsersController],
  providers: [JwtService, ConfigService, PrismaService, BcryptService, UsersService],
})
export class UsersModule { }
