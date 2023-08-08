import { Injectable } from '@nestjs/common';
import { AuthDto } from './dto/auth.dto';
import { UsersService } from 'src/users/users.service';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { BcryptService } from 'src/services/bcrypt.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly configService: ConfigService,
    private readonly jwtService: JwtService,
    private readonly bcrypt: BcryptService,
  ) {}

  async authenticate(authData: AuthDto) {
    try {
      const user = await this.usersService.findByEmail(authData.email);

      const jwtSecret = this.configService.get('JWT_SECRET');

      if (user && user.password) {
        if (await this.bcrypt.compare(authData.password, user.password)) {
          const token = await this.jwtService.signAsync(
            { id: user.id },
            { secret: jwtSecret, expiresIn: '7d' },
          );
          return { token, ...user };
        }
      }

      return null;
    } catch (e) {
      console.log(e);
      return null;
    }
  }

  async renewToken(userId: string) {
    try {
      const jwtSecret = this.configService.get('JWT_SECRET');

      const user = await this.usersService.findOne(userId);

      const token = await this.jwtService.signAsync(
        { id: userId },
        { secret: jwtSecret, expiresIn: '7d' },
      );
      return { token, ...user };
    } catch (e) {
      console.log(e);
      return null;
    }
  }
}
