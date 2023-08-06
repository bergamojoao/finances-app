import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { google, Auth } from 'googleapis';
import { PrismaService } from 'src/services/prisma.service';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class GoogleAuthenticationService {
  oauthClient: Auth.OAuth2Client;
  constructor(
    private readonly usersService: UsersService,
    private readonly prisma: PrismaService,
    private readonly configService: ConfigService,
    private readonly httpService: HttpService,
    private readonly jwtService: JwtService
    //private readonly authenticationService: AuthenticationService
  ) {
    const clientID = this.configService.get('GOOGLE_AUTH_CLIENT_ID');
    const clientSecret = this.configService.get('GOOGLE_AUTH_CLIENT_SECRET');

    this.oauthClient = new google.auth.OAuth2(
      clientID,
      clientSecret
    );
  }

  async authenticate(token: string) {
    try {

      const tokenInfo = await this.oauthClient.getTokenInfo(token);

      const email = tokenInfo.email;

      const user = await this.usersService.findByEmail(email);

      const jwtSecret = this.configService.get('JWT_SECRET');

      if (user) {
        const token = await this.jwtService.signAsync({ id: user.id }, { secret: jwtSecret, expiresIn: '7d' });

        return { token, ...user };
      }

      const response = await this.httpService.axiosRef.get('https://www.googleapis.com/oauth2/v3/userinfo', {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });

      if (response.status === 200) {
        const { given_name: name, family_name: lastName, picture } = response.data;

        const { password: _, ...user } = await this.prisma.user.create({
          data: {
            email,
            name: name + ' ' + lastName,
            picture,
            role: 'user',
          }
        });

        const token = await this.jwtService.signAsync({ id: user.id }, { secret: jwtSecret, expiresIn: '7d' });

        return { token, ...user };
      }

      return null;
    } catch (e) {
      console.log(e);
      return null;
    }
  }
}
