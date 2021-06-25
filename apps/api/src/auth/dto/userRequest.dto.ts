import { ApiProperty } from '@nestjs/swagger';

export class UserRequestDTO {
  @ApiProperty()
  username: string;

  @ApiProperty()
  password: string;
}
