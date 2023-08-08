import { Injectable } from '@nestjs/common';
import { CreateTransactionDto } from './dto/create-transaction.dto';
import { UpdateTransactionDto } from './dto/update-transaction.dto';
import { PrismaService } from 'src/services/prisma.service';
import * as moment from 'moment';
import { QueryTransactionDto } from './dto/query-transaction.dto';

@Injectable()
export class TransactionsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(createTransactionDto: CreateTransactionDto, userId: string) {
    const transaction = await this.prisma.transaction.create({
      data: {
        date: createTransactionDto.date,
        type: createTransactionDto.type,
        category: createTransactionDto.category,
        value: createTransactionDto.value,
        userId: userId,
      },
    });
    return transaction;
  }

  async findAll(params: QueryTransactionDto, userId: string) {
    let monthStart: Date;
    let monthEnd: Date;

    if (params.month && params.year) {
      monthStart = moment([params.year, params.month - 1]).toDate();
      monthEnd = moment([params.year, params.month - 1])
        .endOf('month')
        .toDate();
    }

    const transactions = await this.prisma.transaction.findMany({
      where: {
        userId,
        ...(params.month && params.year
          ? {
              date: {
                lte: monthEnd,
                gte: monthStart,
              },
            }
          : {}),
      },
    });
    return transactions;
  }

  findOne(id: number) {
    return `This action returns a #${id} transaction`;
  }

  update(id: number, updateTransactionDto: UpdateTransactionDto) {
    return `This action updates a #${id} transaction`;
  }

  remove(id: number) {
    return `This action removes a #${id} transaction`;
  }
}
