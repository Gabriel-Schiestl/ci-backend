import { Inject, Injectable } from '@nestjs/common';
import { RepositoryNoDataFound } from 'src/shared/exceptions/RepositoryNoDataFound.exception';
import { TechnicalException } from 'src/shared/exceptions/Technical.exception';
import { Res, Result } from 'src/shared/Result';
import { ReportDto } from '../../dto/Report.dto';
import { ReportAppMapper } from '../../mappers/Report.mapper';
import { AbstractUseCase } from 'src/shared/AbstractUseCase';
import { ReportRepository } from 'src/modules/core/domain/repositories/Report.repository';
import { AgriculturalEngineerRepository } from 'src/modules/engineer/domain/repositories/AgriculturalEngineer.repository';

export type GetAllReportsUseCaseExceptions =
    | RepositoryNoDataFound
    | TechnicalException;

@Injectable()
export class GetAllReportsUseCase extends AbstractUseCase<
    { userId: string },
    GetAllReportsUseCaseExceptions,
    ReportDto[]
> {
    constructor(
        @Inject('ReportRepository')
        private readonly reportRepository: ReportRepository,
        @Inject('AgriculturalEngineerRepository')
        private readonly engineerRepository: AgriculturalEngineerRepository,
    ) {
        super();
    }

    async onExecute({
        userId,
    }: {
        userId: string;
    }): Promise<Result<GetAllReportsUseCaseExceptions, ReportDto[]>> {
        const engineer = await this.engineerRepository.getByUserId(userId);
        if (engineer.isFailure()) {
            return Res.failure(engineer.error);
        }

        const reports = await this.reportRepository.getByEngineerId(
            engineer.value.id,
        );
        if (reports.isFailure()) {
            return Res.failure(reports.error);
        }

        return Res.success(
            reports.value.map((report) => ReportAppMapper.toDto(report)),
        );
    }
}
