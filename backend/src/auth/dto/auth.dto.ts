import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsEmail,
  IsNotEmpty,
  IsOptional,
  IsString,
  IsStrongPassword,
} from 'class-validator';

export class AuthDto {
  @ApiProperty({ example: 'test@email.com' })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @ApiProperty({ example: 'mystrongpassword123' })
  @IsStrongPassword({
    minSymbols: 0,
  })
  @IsNotEmpty()
  password: string;
}
