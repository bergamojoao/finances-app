import {
  Body,
  Controller,
  Get,
  Post,
  Req,
  UnauthorizedException,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthDto } from './dto/auth.dto';
import { Request } from 'express';
import * as moment from 'moment';
import { AuthGuard } from './auth.guard';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post()
  async authenticate(@Body() authData: AuthDto, @Req() request: Request) {
    const user = await this.authService.authenticate(authData);

    if (user) {
      request.res.cookie('token', user.token, {
        httpOnly: true,
        expires: moment(new Date()).add(7, 'days').toDate(),
      });
      return user;
    }

    throw new UnauthorizedException();
  }

  @Get('status')
  @UseGuards(AuthGuard)
  async status(@Req() request: Request) {
    const user = request['user'];

    if (user) {
      const renewedUser = await this.authService.renewToken(user['id']);
      request.res.cookie('token', renewedUser.token, {
        httpOnly: true,
        expires: moment(new Date()).add(7, 'days').toDate(),
      });
      return renewedUser;
    }

    throw new UnauthorizedException();
  }
}
