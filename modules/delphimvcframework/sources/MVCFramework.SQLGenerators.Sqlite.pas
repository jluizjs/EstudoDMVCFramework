// *************************************************************************** }
//
// Delphi MVC Framework
//
// Copyright (c) 2010-2019 Daniele Teti and the DMVCFramework Team
//
// https://github.com/danieleteti/delphimvcframework
//
// ***************************************************************************
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ***************************************************************************

unit MVCFramework.SQLGenerators.Sqlite;

interface

uses
  System.Rtti,
  System.Generics.Collections,
  MVCFramework.ActiveRecord,
  MVCFramework.Commons,
  MVCFramework.RQL.Parser;

type
  TMVCSQLGeneratorSQLite = class(TMVCSQLGenerator)
  protected
    function GetCompilerClass: TRQLCompilerClass; override;
  public
    function CreateSelectSQL(
      const TableName: string;
      const Map: TDictionary<TRttiField, string>;
      const PKFieldName: string;
      const PKOptions: TMVCActiveRecordFieldOptions): string; override;
    function CreateInsertSQL(
      const TableName: string;
      const Map: TDictionary<TRttiField, string>;
      const PKFieldName: string;
      const PKOptions: TMVCActiveRecordFieldOptions): string; override;
    function CreateUpdateSQL(
      const TableName: string;
      const Map: TDictionary<TRttiField, string>;
      const PKFieldName: string;
      const PKOptions: TMVCActiveRecordFieldOptions): string; override;
    function CreateDeleteSQL(
      const TableName: string;
      const Map: TDictionary<TRttiField, string>;
      const PKFieldName: string;
      const PKOptions: TMVCActiveRecordFieldOptions;
      const PrimaryKeyValue: Int64): string; override;
    function CreateDeleteAllSQL(
      const TableName: string): string; override;
    function CreateSelectByPKSQL(
      const TableName: string;
      const Map: TDictionary<TRttiField, string>; const PKFieldName: string;
      const PKOptions: TMVCActiveRecordFieldOptions;
      const PrimaryKeyValue: Int64): string; override;
    function CreateSQLWhereByRQL(
      const RQL: string;
      const Mapping: TMVCFieldsMapping;
      const UseArtificialLimit: Boolean = True): string; override;
    function CreateSelectCount(
      const TableName: String): String; override;
  end;

implementation

uses
  System.SysUtils,
  MVCFramework.RQL.AST2SQLite;

function TMVCSQLGeneratorSQLite.CreateInsertSQL(const TableName: string; const Map: TDictionary<TRttiField, string>;
  const PKFieldName: string; const PKOptions: TMVCActiveRecordFieldOptions): string;
var
  lKeyValue: TPair<TRttiField, string>;
  lSB: TStringBuilder;
begin
  lSB := TStringBuilder.Create;
  try
    lSB.Append('INSERT INTO ' + TableName + ' (');
    for lKeyValue in Map do
      lSB.Append(lKeyValue.value + ',');
    lSB.Remove(lSB.Length - 1, 1);
    lSB.Append(') values (');
    for lKeyValue in Map do
    begin
      lSB.Append(':' + lKeyValue.value + ',');
    end;
    lSB.Remove(lSB.Length - 1, 1);
    lSB.Append(')');

    if TMVCActiveRecordFieldOption.foAutoGenerated in PKOptions then
    begin
      lSB.Append(' ; SELECT last_insert_rowid() as ' + PKFieldName + ';');
    end;
    Result := lSB.ToString;
  finally
    lSB.Free;
  end;
end;

function TMVCSQLGeneratorSQLite.CreateSelectByPKSQL(
  const TableName: string;
  const Map: TDictionary<TRttiField, string>; const PKFieldName: string;
  const PKOptions: TMVCActiveRecordFieldOptions;
  const PrimaryKeyValue: Int64): string;
begin
  Result := CreateSelectSQL(TableName, Map, PKFieldName, PKOptions) + ' WHERE ' +
    PKFieldName + '= :' + PKFieldName; // IntToStr(PrimaryKeyValue);
end;

function TMVCSQLGeneratorSQLite.CreateSelectCount(
  const TableName: String): String;
begin
  Result := 'SELECT count(*) FROM ' + TableName;
end;

function TMVCSQLGeneratorSQLite.CreateSelectSQL(const TableName: string;
  const Map: TDictionary<TRttiField, string>; const PKFieldName: string;
  const PKOptions: TMVCActiveRecordFieldOptions): string;
begin
  Result := 'SELECT ' + TableFieldsDelimited(Map, PKFieldName, ',') + ' FROM ' + TableName;
end;

function TMVCSQLGeneratorSQLite.CreateSQLWhereByRQL(
  const RQL: string;
  const Mapping: TMVCFieldsMapping;
  const UseArtificialLimit: Boolean): string;
var
  lSQLiteCompiler: TRQLSQLiteCompiler;
begin
  lSQLiteCompiler := TRQLSQLiteCompiler.Create(Mapping);
  try
    GetRQLParser.Execute(RQL, Result, lSQLiteCompiler, UseArtificialLimit);
  finally
    lSQLiteCompiler.Free;
  end;
end;

function TMVCSQLGeneratorSQLite.CreateUpdateSQL(const TableName: string; const Map: TDictionary<TRttiField, string>;
  const PKFieldName: string; const PKOptions: TMVCActiveRecordFieldOptions): string;
var
  keyvalue: TPair<TRttiField, string>;
begin
  Result := 'UPDATE ' + TableName + ' SET ';
  for keyvalue in Map do
  begin
    Result := Result + keyvalue.value + ' = :' + keyvalue.value + ',';
  end;
  Result[Length(Result)] := ' ';
  if not PKFieldName.IsEmpty then
  begin
    Result := Result + ' where ' + PKFieldName + '= :' + PKFieldName;
  end;
end;

function TMVCSQLGeneratorSQLite.GetCompilerClass: TRQLCompilerClass;
begin
  Result := TRQLSQLiteCompiler;
end;

function TMVCSQLGeneratorSQLite.CreateDeleteAllSQL(
  const TableName: string): string;
begin
  Result := 'DELETE FROM ' + TableName;
end;

function TMVCSQLGeneratorSQLite.CreateDeleteSQL(const TableName: string; const Map: TDictionary<TRttiField, string>;
  const PKFieldName: string; const PKOptions: TMVCActiveRecordFieldOptions; const PrimaryKeyValue: Int64): string;
begin
  Result := CreateDeleteAllSQL(TableName) + ' WHERE ' + PKFieldName + '=' + IntToStr(PrimaryKeyValue);
end;

initialization

TMVCSQLGeneratorRegistry.Instance.RegisterSQLGenerator('sqlite', TMVCSQLGeneratorSQLite);

finalization

TMVCSQLGeneratorRegistry.Instance.UnRegisterSQLGenerator('sqlite');

end.
