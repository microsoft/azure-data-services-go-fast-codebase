import moment from 'moment';
import {tz} from 'moment-timezone';
import {
    AccessToken,
    Event,
    InviteCsvRow,
    Invitee,
    InviteeStatus as ApiInviteeStatus,
    InviteeSummary,
    Program,
    ProgramStatus as ApiProgramStatus,
} from '../services/api/api-client';

export enum ProgramStatus {
    Pending = 'pending',
    Open = 'open',
    Closed = 'closed'
}

export enum InviteeStatus {
    Pending = 'pending',
    Completed = 'completed',
    Bounced = 'bounced'
}

export type ProgramState = {
    id: string;
    name: string;
    timeZone: string;
    opens: string;
    closes: string;
    status: ProgramStatus;

    invitesSent: number;
    invitesUploaded: number;
    invitesBounced: number;

    invitees: InviteeState[];
};

export type InviteeState = {
    id: string;
    name: string;
    emailAddress: string;
    status: InviteeStatus;
    details: InviteeDetails;
    isOpen: boolean;
    isLoaded: boolean;
};

export type InviteeDetails = {
    folderName: string;
    phn: string;
    practiceId: string;
    crmId: string;
    accessTokens: AccessTokenState[];
    inviteeEvents: InviteeEventState[];
};

export type AccessTokenState = {
    id: string;
    isActive: boolean;
    startsOn: string;
    endsOn: string;
    generatedOn: string;
    generatedBy: string;
};

export type InviteeEventState = {
    id: string;
    performedOn: string;
    performedBy: string;
    description: string;
};

export const initProgram: ProgramState = {
    id: '',
    name: '',
    timeZone: tz.guess(),
    opens: '',
    closes: '',
    invitesSent: 0,
    invitesUploaded: 0,
    invitesBounced: 0,
    status: ProgramStatus.Pending,
    invitees: [],
};

export function castProgramFromDto(programDto: Program): ProgramState {
    return {
        id: programDto.id,
        name: programDto.name,
        timeZone: programDto.timeZone,
        status: ProgramStatus[ApiProgramStatus[programDto.status]],
        opens: moment(programDto.commencementDate).utc().format('yyyy-MM-DDTHH:mm:ss'),
        closes: moment(programDto.submissionDeadline).utc().format('yyyy-MM-DDTHH:mm:ss'),
        invitesSent: programDto.invitees?.filter(x => x.hasBeenInvited).length ?? 0,
        invitesUploaded: programDto.invitees?.filter(x => x.hasUploaded).length ?? 0,
        invitesBounced: 0,
        invitees: programDto.invitees?.map((dto) => castInviteeFromDtoShallow(dto)) ?? [],
    };
}

export function castInviteeFromDtoShallow(inviteeDto: InviteeSummary): InviteeState {
    return {
        id: inviteeDto.id,
        name: inviteeDto.practiceName,
        emailAddress: inviteeDto.emailAddress,
        status: InviteeStatus[ApiInviteeStatus[inviteeDto.status]],
        isOpen: false,
        isLoaded: false,
        details: {
            folderName: '',
            crmId: '',
            phn: '',
            practiceId: '',
            accessTokens: [],
            inviteeEvents: [],
        },
    };
}

export function castInviteeFromDtoDeep(inviteeDto: Invitee): InviteeState {
    return {
        id: inviteeDto.id,
        name: inviteeDto.practiceName,
        emailAddress: inviteeDto.emailAddress,
        status: InviteeStatus[ApiInviteeStatus[inviteeDto.status]],
        isOpen: false,
        isLoaded: false,
        details: {
            folderName: inviteeDto.folderName,
            crmId: inviteeDto.crmId,
            phn: inviteeDto.phn,
            practiceId: inviteeDto.practiceId,
            accessTokens:
                inviteeDto.accessTokens?.map((dto) => castAccessTokenFromDto(dto)) ?? [],
            inviteeEvents:
                inviteeDto.events?.map((dto) => castInviteeEventFromDto(dto)) ?? [],
        },
    };
}

export function castAccessTokenFromDto(
    accessTokenDto: AccessToken
): AccessTokenState {
    return {
        id: accessTokenDto.id ?? '',
        startsOn: moment(accessTokenDto.activeWindowStartsAt ?? '').format(
            'yyyy-MM-DD'
        ),
        endsOn: moment(accessTokenDto.activeWindowEndsAt ?? '').format(
            'yyyy-MM-DD'
        ),
        generatedOn: moment(accessTokenDto.generatedAt ?? '').format(
            'yyyy-MM-DD'
        ),
        generatedBy: accessTokenDto.generatedBy,
        isActive: accessTokenDto.isActive ?? false,
    };
}

export function castInviteeEventFromDto(
    inviteeEventDto: Event
): InviteeEventState {
    return {
        id: '',
        description: inviteeEventDto.description,
        performedOn: moment(inviteeEventDto.triggeredAt ?? '').format(
            'yyyy-MM-DD'
        ),
        performedBy: inviteeEventDto.triggeredBy,
    };
}

export function castCsvRowFromDto(csvRow: InviteCsvRow): InviteeState {
    return {
        id: '',
        name: csvRow.generalPracticeName ?? '',
        emailAddress: csvRow.genericEmailAddress ?? '',
        status: InviteeStatus.Pending,
        isOpen: false,
        isLoaded: false,
        details: {
            folderName: csvRow.folderName ?? '',
            crmId: '',
            phn: '',
            practiceId: '',
            accessTokens: [],
            inviteeEvents: [],
        },
    };
}
