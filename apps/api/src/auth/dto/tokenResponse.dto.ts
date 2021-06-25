import { ApiProperty } from '@nestjs/swagger';

export class TokenResponseDTO {
  @ApiProperty()
  access_token: string;
}
