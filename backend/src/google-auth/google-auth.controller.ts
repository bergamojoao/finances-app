import {
  Body,
  Controller,
  Post,
  Req,
  Res,
  UnauthorizedException,
} from '@nestjs/common';
import { GoogleAuthenticationService } from './google-auth.service';
import { TokenVerificationDto } from './dto/token-verification.dto';
import { Request } from 'express';
import * as moment from 'moment';

@Controller('google-auth')
export class GoogleAuthenticationController {
  constructor(
    private readonly googleAuthenticationService: GoogleAuthenticationService,
  ) {}

  @Post()
  async authenticate(
    @Body() tokenData: TokenVerificationDto,
    @Req() request: Request,
  ) {
    const user = await this.googleAuthenticationService.authenticate(
      tokenData.token,
    );

    if (user) {
      request.res.cookie('token', user.token, {
        httpOnly: true,
        expires: moment(new Date()).add(7, 'days').toDate(),
      });
      return user;
    }

    throw new UnauthorizedException();
  }
}
