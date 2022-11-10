/* eslint-disable */
/* tslint:disable */
/*
 * ---------------------------------------------------------------
 * ## THIS FILE WAS GENERATED VIA SWAGGER-TYPESCRIPT-API        ##
 * ##                                                           ##
 * ## AUTHOR: acacode                                           ##
 * ## SOURCE: https://github.com/acacode/swagger-typescript-api ##
 * ---------------------------------------------------------------
 */

export interface AccessToken {
  /** @format uuid */
  id?: string;
  isActive?: boolean;
  /** @format date-time */
  generatedAt?: string;
  /** @format date-time */
  activeWindowStartsAt?: string;
  /** @format date-time */
  activeWindowEndsAt?: string;
  generatedBy: string;
  token?: string | null;
}

export interface BadRequestResult {
  /** @format int32 */
  statusCode?: number;
}

export interface Event {
  /** @format date-time */
  triggeredAt?: string;
  description: string;
  triggeredBy: string;
}

export interface InviteCsvRow {
  crmId?: string | null;
  phn?: string | null;
  practiceId?: string | null;
  generalPracticeName?: string | null;
  folderName?: string | null;
  genericEmailAddress?: string | null;
  reportingQuarter?: string | null;
}

export interface Invitee {
  /** @format uuid */
  id: string;
  crmId: string;
  phn: string;
  practiceId: string;
  practiceName: string;
  folderName: string;
  emailAddress: string;
  containerName: string;
  reportingQuarter: string;
  status: InviteeStatus;
  accessTokens?: AccessToken[] | null;
  events?: Event[] | null;
  sendGridEmails?: SendGridEmail[] | null;
}

export enum InviteeStatus {
  Pending = 'Pending',
  Completed = 'Completed',
  Bounced = 'Bounced',
}

export interface InviteeSummary {
  /** @format uuid */
  id: string;
  practiceName: string;
  emailAddress: string;
  hasBeenInvited: boolean;
  hasUploaded: boolean;
  status: InviteeStatus;
  bounceResponses: SendGridEmail[];
}

export interface LookupIdentifier {
  /** @format uuid */
  id?: string;
}

export interface ProblemDetails {
  type?: string | null;
  title?: string | null;
  /** @format int32 */
  status?: number | null;
  detail?: string | null;
  instance?: string | null;
}

export interface Program {
  /** @format uuid */
  id: string;
  name: string;
  /** @format date-time */
  commencementDate: string;
  /** @format date-time */
  submissionDeadline: string;
  timeZone: string;
  invitees: InviteeSummary[];
  status: ProgramStatus;
}

export enum ProgramStatus {
  Pending = 'Pending',
  Open = 'Open',
  Closed = 'Closed',
}

export interface ProgramSummary {
  /** @format uuid */
  id: string;
  name: string;
  /** @format date-time */
  commencementDate: string;
  /** @format date-time */
  submissionDeadline: string;
  /** @format int32 */
  numberOfInvitees: number;
  /** @format int32 */
  numberOfInviteesThatHaveUploaded: number;
  status: ProgramStatus;
}

export interface SearchProgramsFilter {
  showClosedPrograms?: boolean;
}

export interface SendGridEmail {
  sendGridId?: string | null;
  /** @format date-time */
  sentOn?: string;
  /** @format date-time */
  bouncedOn?: string | null;
  bouncedReason?: string | null;
  email?: string | null;
}

export interface Settings {
  /** @format int32 */
  minFileSize: number;
  /** @format int32 */
  maxFileSize: number;
  fileUnit: string;
  notificationFromEmailAddress: string;
  notificationFromDisplayName: string;
  inviteNotificationSendGridTemplateId: string;
  confirmationNotificationSendGridTemplateId: string;
  /** @format int32 */
  inviteTimeToLiveDays: number;
  phnLogo?: string | null;
  allowCsvFiles: boolean;
  allowJsonFiles: boolean;
  allowZippedFiles: boolean;
  bounceNotificationEmailAddress: string;
}

export interface SettingsSummary {
  logo?: string | null;
}

export type QueryParamsType = Record<string | number, any>;
export type ResponseFormat = keyof Omit<Body, 'body' | 'bodyUsed'>;

export interface FullRequestParams extends Omit<RequestInit, 'body'> {
  /** set parameter to `true` for call `securityWorker` for this request */
  secure?: boolean;
  /** request path */
  path: string;
  /** content type of request body */
  type?: ContentType;
  /** query params */
  query?: QueryParamsType;
  /** format of response (i.e. response.json() -> format: "json") */
  format?: ResponseFormat;
  /** request body */
  body?: unknown;
  /** base url */
  baseUrl?: string;
  /** request cancellation token */
  cancelToken?: CancelToken;
}

export type RequestParams = Omit<
  FullRequestParams,
  'body' | 'method' | 'query' | 'path'
>;

export interface ApiConfig<SecurityDataType = unknown> {
  baseUrl?: string;
  baseApiParams?: Omit<RequestParams, 'baseUrl' | 'cancelToken' | 'signal'>;
  securityWorker?: (
    securityData: SecurityDataType | null
  ) => Promise<RequestParams | void> | RequestParams | void;
  customFetch?: typeof fetch;
}

export interface HttpResponse<D extends unknown, E extends unknown = unknown>
  extends Response {
  data: D;
  error: E;
}

type CancelToken = Symbol | string | number;

export enum ContentType {
  Json = 'application/json',
  FormData = 'multipart/form-data',
  UrlEncoded = 'application/x-www-form-urlencoded',
}

export class HttpClient<SecurityDataType = unknown> {
  public baseUrl: string = '';
  private securityData: SecurityDataType | null = null;
  private securityWorker?: ApiConfig<SecurityDataType>['securityWorker'];
  private abortControllers = new Map<CancelToken, AbortController>();
  private customFetch = (...fetchParams: Parameters<typeof fetch>) =>
    fetch(...fetchParams);

  private baseApiParams: RequestParams = {
    credentials: 'same-origin',
    headers: {},
    redirect: 'follow',
    referrerPolicy: 'no-referrer',
  };

  constructor(apiConfig: ApiConfig<SecurityDataType> = {}) {
    Object.assign(this, apiConfig);
  }

  public setSecurityData = (data: SecurityDataType | null) => {
    this.securityData = data;
  };

  protected encodeQueryParam(key: string, value: any) {
    const encodedKey = encodeURIComponent(key);
    return `${encodedKey}=${encodeURIComponent(
      typeof value === 'number' ? value : `${value}`
    )}`;
  }

  protected addQueryParam(query: QueryParamsType, key: string) {
    return this.encodeQueryParam(key, query[key]);
  }

  protected addArrayQueryParam(query: QueryParamsType, key: string) {
    const value = query[key];
    return value.map((v: any) => this.encodeQueryParam(key, v)).join('&');
  }

  protected toQueryString(rawQuery?: QueryParamsType): string {
    const query = rawQuery || {};
    const keys = Object.keys(query).filter(
      (key) => 'undefined' !== typeof query[key]
    );
    return keys
      .map((key) =>
        Array.isArray(query[key])
          ? this.addArrayQueryParam(query, key)
          : this.addQueryParam(query, key)
      )
      .join('&');
  }

  protected addQueryParams(rawQuery?: QueryParamsType): string {
    const queryString = this.toQueryString(rawQuery);
    return queryString ? `?${queryString}` : '';
  }

  private contentFormatters: Record<ContentType, (input: any) => any> = {
    [ContentType.Json]: (input: any) =>
      input !== null && (typeof input === 'object' || typeof input === 'string')
        ? JSON.stringify(input)
        : input,
    [ContentType.FormData]: (input: any) =>
      Object.keys(input || {}).reduce((formData, key) => {
        const property = input[key];
        formData.append(
          key,
          property instanceof Blob
            ? property
            : typeof property === 'object' && property !== null
            ? JSON.stringify(property)
            : `${property}`
        );
        return formData;
      }, new FormData()),
    [ContentType.UrlEncoded]: (input: any) => this.toQueryString(input),
  };

  protected mergeRequestParams(
    params1: RequestParams,
    params2?: RequestParams
  ): RequestParams {
    return {
      ...this.baseApiParams,
      ...params1,
      ...(params2 || {}),
      headers: {
        ...(this.baseApiParams.headers || {}),
        ...(params1.headers || {}),
        ...((params2 && params2.headers) || {}),
      },
    };
  }

  protected createAbortSignal = (
    cancelToken: CancelToken
  ): AbortSignal | undefined => {
    if (this.abortControllers.has(cancelToken)) {
      const abortController = this.abortControllers.get(cancelToken);
      if (abortController) {
        return abortController.signal;
      }
      return void 0;
    }

    const abortController = new AbortController();
    this.abortControllers.set(cancelToken, abortController);
    return abortController.signal;
  };

  public abortRequest = (cancelToken: CancelToken) => {
    const abortController = this.abortControllers.get(cancelToken);

    if (abortController) {
      abortController.abort();
      this.abortControllers.delete(cancelToken);
    }
  };

  public request = async <T = any, E = any>({
    body,
    secure,
    path,
    type,
    query,
    format,
    baseUrl,
    cancelToken,
    ...params
  }: FullRequestParams): Promise<HttpResponse<T, E>> => {
    const secureParams =
      ((typeof secure === 'boolean' ? secure : this.baseApiParams.secure) &&
        this.securityWorker &&
        (await this.securityWorker(this.securityData))) ||
      {};
    const requestParams = this.mergeRequestParams(params, secureParams);
    const queryString = query && this.toQueryString(query);
    const payloadFormatter = this.contentFormatters[type || ContentType.Json];
    const responseFormat = format || requestParams.format;

    return this.customFetch(
      `${baseUrl || this.baseUrl || ''}${path}${
        queryString ? `?${queryString}` : ''
      }`,
      {
        ...requestParams,
        headers: {
          ...(requestParams.headers || {}),
          ...(type && type !== ContentType.FormData
            ? { 'Content-Type': type }
            : {}),
        },
        signal: cancelToken
          ? this.createAbortSignal(cancelToken)
          : requestParams.signal,
        body:
          typeof body === 'undefined' || body === null
            ? null
            : payloadFormatter(body),
      }
    ).then(async (response) => {
      const r = response as HttpResponse<T, E>;
      r.data = null as unknown as T;
      r.error = null as unknown as E;

      const data = !responseFormat
        ? r
        : await response[responseFormat]()
            .then((data) => {
              if (r.ok) {
                r.data = data;
              } else {
                r.error = data;
              }
              return r;
            })
            .catch((e) => {
              r.error = e;
              return r;
            });

      if (cancelToken) {
        this.abortControllers.delete(cancelToken);
      }

      if (!response.ok) throw data;
      return data;
    });
  };
}

/**
 * @title Secure File Uploader API
 * @version v1
 */
export class Api<
  SecurityDataType extends unknown
> extends HttpClient<SecurityDataType> {
  api = {
    /**
     * No description
     *
     * @tags Invitees
     * @name InviteesDetail
     * @summary Retrieves the invitee assigned to the provided id.
     * @request GET:/api/invitees/{id}
     */
    inviteesDetail: (id: string, params: RequestParams = {}) =>
      this.request<Invitee, void>({
        path: `/api/invitees/${id}`,
        method: 'GET',
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Invitees
     * @name InviteesTokenCreate
     * @summary Create a token by a given Invitee.
     * @request POST:/api/invitees/token/{id}
     */
    inviteesTokenCreate: (id: string, params: RequestParams = {}) =>
      this.request<AccessToken, ProblemDetails>({
        path: `/api/invitees/token/${id}`,
        method: 'POST',
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Programs
     * @name ProgramsFileCreate
     * @summary Creates a Program and Invitees.
     * @request POST:/api/programs/file
     */
    programsFileCreate: (
      data: {
        Name: string;
        /** @format date-time */
        CommencementDate: string;
        /** @format date-time */
        SubmissionDeadline: string;
        TimeZone: string;
        /** @format binary */
        File: File;
      },
      params: RequestParams = {}
    ) =>
      this.request<LookupIdentifier, ProblemDetails | void>({
        path: `/api/programs/file`,
        method: 'POST',
        body: data,
        type: ContentType.FormData,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Programs
     * @name ProgramsUpdate
     * @summary Updates a Program with the given Id.
     * @request PUT:/api/programs/{id}
     */
    programsUpdate: (
      id: string,
      data: {
        Name: string;
        /** @format date-time */
        CommencementDate: string;
        /** @format date-time */
        SubmissionDeadline: string;
        TimeZone: string;
      },
      params: RequestParams = {}
    ) =>
      this.request<Program, ProblemDetails>({
        path: `/api/programs/${id}`,
        method: 'PUT',
        body: data,
        type: ContentType.FormData,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Programs
     * @name ProgramsDetail
     * @summary Retrieves the program assigned to the provided id.
     * @request GET:/api/programs/{id}
     */
    programsDetail: (id: string, params: RequestParams = {}) =>
      this.request<Program, ProblemDetails>({
        path: `/api/programs/${id}`,
        method: 'GET',
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Programs
     * @name ProgramsSearchCreate
     * @summary Gets a list of programs matching the provided search term.
     * @request POST:/api/programs/search
     */
    programsSearchCreate: (
      data: SearchProgramsFilter,
      query?: {
        /**
         * The search term.
         * @example Prog
         */
        searchTerm?: string;
      },
      params: RequestParams = {}
    ) =>
      this.request<ProgramSummary[], any>({
        path: `/api/programs/search`,
        method: 'POST',
        query: query,
        body: data,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Programs
     * @name StageFile
     * @request POST:/api/programs/stage-file
     */
    stageFile: (
      data: {
        /** @format binary */
        File: File;
      },
      params: RequestParams = {}
    ) =>
      this.request<InviteCsvRow[], ProblemDetails>({
        path: `/api/programs/stage-file`,
        method: 'POST',
        body: data,
        type: ContentType.FormData,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Settings
     * @name SettingsList
     * @summary List current System Settings
     * @request GET:/api/settings
     */
    settingsList: (params: RequestParams = {}) =>
      this.request<Settings, any>({
        path: `/api/settings`,
        method: 'GET',
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Settings
     * @name SettingsUpdate
     * @request PUT:/api/settings
     */
    settingsUpdate: (
      data: {
        /** @format int32 */
        MinFileSize: number;
        /** @format int32 */
        MaxFileSize: number;
        FileUnit: string;
        NotificationFromEmailAddress: string;
        NotificationFromDisplayName: string;
        InviteNotificationSendGridTemplateId: string;
        ConfirmationNotificationSendGridTemplateId: string;
        /** @format int32 */
        InviteTimeToLiveDays: number;
        PhnLogo?: string;
        AllowCsvFiles: boolean;
        AllowJsonFiles: boolean;
        AllowZippedFiles: boolean;
        BounceNotificationEmailAddress: string;
      },
      params: RequestParams = {}
    ) =>
      this.request<string, BadRequestResult>({
        path: `/api/settings`,
        method: 'PUT',
        body: data,
        type: ContentType.FormData,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Settings
     * @name SettingsLogoList
     * @request GET:/api/settings/logo
     */
    settingsLogoList: (params: RequestParams = {}) =>
      this.request<SettingsSummary, any>({
        path: `/api/settings/logo`,
        method: 'GET',
        format: 'json',
        ...params,
      }),
  };
}
