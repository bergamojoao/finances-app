import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaService } from 'src/services/prisma.service';
import { BcryptService } from 'src/services/bcrypt.service';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService, private bcrypt: BcryptService) {}

  async create(createUserDto: CreateUserDto) {
    const { password: _, ...result } = await this.prisma.user.create({
      data: {
        name: createUserDto.name,
        email: createUserDto.email,
        password: await this.bcrypt.hash(createUserDto.password),
        phone: createUserDto.phone,
        role: 'user',
      },
    });
    return result;
  }

  async findAll() {
    const users = await this.prisma.user.findMany({
      select: {
        id: true,
        name: true,
        email: true,
        phone: true,
        role: true,
        active: true,
      },
    });
    return users;
  }

  async findOne(id: string) {
    const { password: _, ...user } = await this.prisma.user.findFirst({
      where: { id },
    });
    return user;
  }

  async findByEmail(email: string) {
    const user = await this.prisma.user.findFirst({
      where: { email },
    });
    return user;
  }

  async update(id: string, updateUserDto: UpdateUserDto) {
    const { password: _, ...user } = await this.prisma.user.update({
      data: {
        name: updateUserDto.name,
        email: updateUserDto.email,
        password: updateUserDto.password
          ? await this.bcrypt.hash(updateUserDto.password)
          : undefined,
        phone: updateUserDto.phone,
      },
      where: { id },
    });
    return user;
  }

  async remove(id: string) {
    await this.prisma.user.update({
      data: { active: false },
      where: { id },
    });
    return;
  }
}
