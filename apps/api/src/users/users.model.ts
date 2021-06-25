import { Column, Table } from 'sequelize-typescript';
import { Base } from 'src/app/base.model';
import { UserRole } from './role.enum';

@Table({ tableName: 'users' })
export class User extends Base {
  @Column
  username: string;

  @Column
  password: string;

  @Column
  role: UserRole;
}
