import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
  UnauthorizedException,
  Query,
  UseGuards,
} from '@nestjs/common';
import { Request } from 'express';

import { TransactionsService } from './transactions.service';
import { CreateTransactionDto } from './dto/create-transaction.dto';
import { UpdateTransactionDto } from './dto/update-transaction.dto';
import { QueryTransactionDto } from './dto/query-transaction.dto';
import { AuthGuard } from 'src/auth/auth.guard';

@Controller('transactions')
@UseGuards(AuthGuard)
export class TransactionsController {
  constructor(private readonly transactionsService: TransactionsService) { }

  @Post()
  create(
    @Body() createTransactionDto: CreateTransactionDto,
    @Req() request: Request,
  ) {
    const user = request['user'];
    if (user) {
      return this.transactionsService.create(createTransactionDto, user['id']);
    }
    throw new UnauthorizedException();
  }

  @Get()
  findAll(@Req() request: Request, @Query() query: QueryTransactionDto) {
    const user = request['user'];
    if (user) {
      return this.transactionsService.findAll(query, user['id']);
    }
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.transactionsService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateTransactionDto: UpdateTransactionDto,
  ) {
    return this.transactionsService.update(+id, updateTransactionDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.transactionsService.remove(+id);
  }
}
