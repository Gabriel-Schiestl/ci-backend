import { Module } from '@nestjs/common';
import { APP_GUARD, Reflector } from '@nestjs/core';
import { EventEmitterModule } from '@nestjs/event-emitter';
import { ScheduleModule } from '@nestjs/schedule';
import {
    ThrottlerGuard,
    ThrottlerModule,
    ThrottlerStorage,
} from '@nestjs/throttler';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OrmConfig } from 'ormconfig';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './modules/auth/auth.module';
import { CalendarModule } from './modules/calendar/calendar.module';
import { CoreModule } from './modules/core/core.module';
import { ResponseInterceptor } from './shared/Response.interceptor';
import { SharedModule } from './shared/shared.module';

@Module({
    imports: [
        TypeOrmModule.forRoot(OrmConfig),
        ScheduleModule.forRoot(),
        CoreModule,
        AuthModule,
        CalendarModule,
        SharedModule,
        EventEmitterModule.forRoot(),
        ThrottlerModule.forRoot([
            {
                name: 'short',
                ttl: Number(process.env.THROTTLE_SHORT_TTL),
                limit: Number(process.env.THROTTLE_SHORT_LIMIT),
            },
            {
                name: 'medium',
                ttl: Number(process.env.THROTTLE_MEDIUM_TTL),
                limit: Number(process.env.THROTTLE_MEDIUM_LIMIT),
            },
            {
                name: 'long',
                ttl: Number(process.env.THROTTLE_LONG_TTL),
                limit: Number(process.env.THROTTLE_LONG_LIMIT),
            },
        ]),
    ],
    providers: [
        AppService,
        ResponseInterceptor,
        {
            provide: APP_GUARD,
            useFactory: (options, storageService, reflector) => {
                return new ThrottlerGuard(options, storageService, reflector);
            },
            inject: ['THROTTLER:MODULE_OPTIONS', ThrottlerStorage, Reflector],
        },
    ],
    controllers: [AppController],
})
export class AppModule {}
