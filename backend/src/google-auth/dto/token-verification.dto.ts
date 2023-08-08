import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty } from 'class-validator';

export class TokenVerificationDto {
  @ApiProperty({ example: 'tokenGoogle' })
  @IsString()
  @IsNotEmpty()
  token: string;
}
