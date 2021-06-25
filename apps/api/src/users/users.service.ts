import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/sequelize';
import { UserDTO } from './dto/user.dto';
import UserMapper from './users.mapper';
import { User } from './users.model';

@Injectable()
export class UsersService {
  constructor(@InjectModel(User) private userModel: typeof User) {}
  async findOne(username: string): Promise<User | undefined> {
    const user = await this.userModel.findOne({
      where: {
        username,
      },
    });
    return user;
  }

  async findAll(): Promise<UserDTO[]> {
    return (await this.userModel.findAll()).map((user) =>
      UserMapper.modelToDTO(user),
    );
  }
}
