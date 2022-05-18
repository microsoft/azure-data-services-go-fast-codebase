CREATE TABLE [dm].[DimMarkInfo]
(
	[MarkInfoKey] bigint NOT NULL,
	[SchoolInfoKey] bigint NOT NULL,
	[ValueName] varchar(255) NULL,
	[PercentageMinimum] numeric(5,2) NULL,
	[PercentageMaximum] numeric(5,2) NULL,
	[PercentagePassingGrade] numeric(5,2) NULL,
	[NumericPrecision] int NULL,
	[NumericScale] int NULL,
	[NumericLow] numeric(5,2) NULL,
	[NumericHigh] numeric(5,2) NULL,
	[NumericPassingGrade] numeric(5,2) NULL,
	[Narrative] varchar(255) NULL,
	[NarrativeMaximumSize] int NULL
)
