import { Controller, Get, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Controller('users')
export class UserController {
  // UseGuards gets through JWT Strategy of 'kaimon-jwt', default is jwt
  @UseGuards(AuthGuard('kaimon-jwt'))
  @Get('me')
  getMe() {
    return 'user info';
  }
}
