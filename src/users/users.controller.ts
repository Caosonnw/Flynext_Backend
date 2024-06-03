import { Controller, Get, Param } from '@nestjs/common';
import { UsersService } from './users.service';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Users')
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get('get-all-users')
  getAllUsers() {
    return this.usersService.getAllUsers();
  }

  @Get('get-user-by-id/:id')
  getUserById(@Param('id') id: number) {
    return this.usersService.getUserById(id);
  }
}
