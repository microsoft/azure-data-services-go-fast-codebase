CREATE TABLE [dm].[DimNaplanNationalAverage] (
    [Year]                         INT             NULL,
    [YearLevel]                    INT             NULL,
    [Domain]                       VARCHAR (255)   NULL,
    [ScaledScore]                  DECIMAL (18, 1) NULL,
    [ScaledScoreStandardDeviation] DECIMAL (18, 1) NULL,
    [NAPLANCategory]               VARCHAR (255)   DEFAULT ('National Average') NULL
);

