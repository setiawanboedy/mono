import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserDTO } from 'src/users/dto/user.dto';
import UserMapper from 'src/users/users.mapper';
import { UsersService } from 'src/users/users.service';
import { TokenResponseDTO } from './dto/tokenResponse.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
  ) {}

  async validateUser(
    username: string,
    password: string,
  ): Promise<UserDTO | null> {
    const user = await this.usersService.findOne(username);
    if (user && (await bcrypt.compare(password, user.password))) {
      return UserMapper.modelToDTO(user);
    }
    return null;
  }

  async login(user: UserDTO): Promise<TokenResponseDTO> {
    const payload = { ...user };

    return {
      access_token: this.jwtService.sign(payload),
    };
  }

  async hashText(text: string): Promise<string> {
    const salt = await bcrypt.genSalt();
    const hash = await bcrypt.hash(text, salt);
    return hash;
  }
}
