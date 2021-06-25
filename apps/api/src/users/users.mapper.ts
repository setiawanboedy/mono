import { UserDTO } from './dto/user.dto';
import { User } from './users.model';

export default class UserMapper {
  public static modelToDTO(user: User): UserDTO {
    const dto = new UserDTO();
    dto.id = user.id;
    dto.role = user.role;
    dto.username = user.username;
    dto.createdAt = user.createdAt;
    dto.updatedAt = user.updatedAt;
    dto.deletedAt = user.deletedAt;
    return dto;
  }
}
