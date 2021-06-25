import { Column, Model, Table } from 'sequelize-typescript';

@Table({ tableName: 'users' })
export class Base extends Model {
  @Column({ primaryKey: true })
  id: number;

  @Column({ field: 'created_at', defaultValue: new Date() })
  createdAt: Date;

  @Column({ field: 'updated_at' })
  updatedAt: Date;

  @Column({ field: 'deleted_at' })
  deletedAt: Date;
}
