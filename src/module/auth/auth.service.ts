import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class AuthService {
  constructor(private prisma: PrismaService) {}
  login() {
    return 'I am logged in';
  }

  signup() {
    return 'I am signed up';
  }
}
