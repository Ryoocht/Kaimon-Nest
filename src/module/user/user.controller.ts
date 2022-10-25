import { Controller, Get, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';

@Controller('users')
export class UserController {
  // UseGuards gets through JWT Strategy of 'kaimon-jwt', default is jwt
  @UseGuards(AuthGuard('kaimon-jwt'))
  @Get('me')
  getMe(@Req() req: Request) {
    return 'user info';
  }
}
