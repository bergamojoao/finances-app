import { Type } from 'class-transformer';
import { IsDate, IsIn, IsNotEmpty, IsNumber } from 'class-validator';

const types = ['incomings', 'outgoings'] as const;
export type TransactionType = (typeof types)[number];

const categories = ['food', 'leisure', 'bills', 'credit-invoice'] as const;
export type TransactionCategory = (typeof categories)[number];

export class CreateTransactionDto {
  @IsNotEmpty()
  @IsDate()
  @Type(() => Date)
  readonly date: Date;

  @IsNotEmpty()
  @IsIn(types)
  type: TransactionType;

  @IsNotEmpty()
  @IsIn(categories)
  category: string;

  @IsNotEmpty()
  @IsNumber()
  value: number;
}
