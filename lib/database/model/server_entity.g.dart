// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetServerRecordCollection on Isar {
  IsarCollection<ServerRecord> get serverRecords => this.collection();
}

const ServerRecordSchema = CollectionSchema(
  name: r'ServerRecord',
  id: 672712065962969915,
  properties: {
    r'ip': PropertySchema(
      id: 0,
      name: r'ip',
      type: IsarType.string,
    ),
    r'lastConnected': PropertySchema(
      id: 1,
      name: r'lastConnected',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _serverRecordEstimateSize,
  serialize: _serverRecordSerialize,
  deserialize: _serverRecordDeserialize,
  deserializeProp: _serverRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'ip': IndexSchema(
      id: 7908241743102109407,
      name: r'ip',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ip',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _serverRecordGetId,
  getLinks: _serverRecordGetLinks,
  attach: _serverRecordAttach,
  version: '3.1.0+1',
);

int _serverRecordEstimateSize(
  ServerRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ip;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _serverRecordSerialize(
  ServerRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ip);
  writer.writeDateTime(offsets[1], object.lastConnected);
  writer.writeString(offsets[2], object.name);
}

ServerRecord _serverRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServerRecord();
  object.id = id;
  object.ip = reader.readStringOrNull(offsets[0]);
  object.lastConnected = reader.readDateTime(offsets[1]);
  object.name = reader.readStringOrNull(offsets[2]);
  return object;
}

P _serverRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _serverRecordGetId(ServerRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _serverRecordGetLinks(ServerRecord object) {
  return [];
}

void _serverRecordAttach(
    IsarCollection<dynamic> col, Id id, ServerRecord object) {
  object.id = id;
}

extension ServerRecordQueryWhereSort
    on QueryBuilder<ServerRecord, ServerRecord, QWhere> {
  QueryBuilder<ServerRecord, ServerRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhere> anyIp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'ip'),
      );
    });
  }
}

extension ServerRecordQueryWhere
    on QueryBuilder<ServerRecord, ServerRecord, QWhereClause> {
  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ip',
        value: [null],
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ip',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipEqualTo(
      String? ip) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ip',
        value: [ip],
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipNotEqualTo(
      String? ip) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ip',
              lower: [],
              upper: [ip],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ip',
              lower: [ip],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ip',
              lower: [ip],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ip',
              lower: [],
              upper: [ip],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipGreaterThan(
    String? ip, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ip',
        lower: [ip],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipLessThan(
    String? ip, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ip',
        lower: [],
        upper: [ip],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipBetween(
    String? lowerIp,
    String? upperIp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ip',
        lower: [lowerIp],
        includeLower: includeLower,
        upper: [upperIp],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipStartsWith(
      String IpPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ip',
        lower: [IpPrefix],
        upper: ['$IpPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ip',
        value: [''],
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterWhereClause> ipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'ip',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'ip',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'ip',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'ip',
              upper: [''],
            ));
      }
    });
  }
}

extension ServerRecordQueryFilter
    on QueryBuilder<ServerRecord, ServerRecord, QFilterCondition> {
  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ip',
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      ipIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ip',
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ip',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ip',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> ipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ip',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      ipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ip',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      lastConnectedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastConnected',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      lastConnectedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastConnected',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      lastConnectedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastConnected',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      lastConnectedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastConnected',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension ServerRecordQueryObject
    on QueryBuilder<ServerRecord, ServerRecord, QFilterCondition> {}

extension ServerRecordQueryLinks
    on QueryBuilder<ServerRecord, ServerRecord, QFilterCondition> {}

extension ServerRecordQuerySortBy
    on QueryBuilder<ServerRecord, ServerRecord, QSortBy> {
  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> sortByIp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ip', Sort.asc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> sortByIpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ip', Sort.desc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> sortByLastConnected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastConnected', Sort.asc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy>
      sortByLastConnectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastConnected', Sort.desc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ServerRecordQuerySortThenBy
    on QueryBuilder<ServerRecord, ServerRecord, QSortThenBy> {
  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> thenByIp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ip', Sort.asc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> thenByIpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ip', Sort.desc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> thenByLastConnected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastConnected', Sort.asc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy>
      thenByLastConnectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastConnected', Sort.desc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ServerRecordQueryWhereDistinct
    on QueryBuilder<ServerRecord, ServerRecord, QDistinct> {
  QueryBuilder<ServerRecord, ServerRecord, QDistinct> distinctByIp(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ip', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QDistinct>
      distinctByLastConnected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastConnected');
    });
  }

  QueryBuilder<ServerRecord, ServerRecord, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ServerRecordQueryProperty
    on QueryBuilder<ServerRecord, ServerRecord, QQueryProperty> {
  QueryBuilder<ServerRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ServerRecord, String?, QQueryOperations> ipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ip');
    });
  }

  QueryBuilder<ServerRecord, DateTime, QQueryOperations>
      lastConnectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastConnected');
    });
  }

  QueryBuilder<ServerRecord, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
