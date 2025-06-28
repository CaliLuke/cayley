# Quality Checklist

This document outlines the results of the quality checks performed on the codebase.

## `go vet` Results

### Unkeyed struct literals: `github.com/cayleygraph/quad.Quad`

The following files contain struct literals that use unkeyed fields:

- **`graph/graphtest/graphtest.go`**: 814, 815, 816, 817, 818, 819, 820, 1108, 1109, 1110, 1111, 1112, 1114
- **`schema/loader_test.go`**: 21, 22, 45, 46, 47, 48, 49, 50, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 217, 218, 219, 220, 221, 237, 238, 239, 240, 241, 349, 350, 360, 367, 368, 369, 387, 388, 389, 390, 403, 404, 405, 407, 408, 409, 410
- **`schema/schema_test.go`**: 147, 148, 149, 150, 151, 153, 154, 156
- **`schema/writer_test.go`**: 79, 80, 81, 82, 84, 85, 86, 88, 89, 90, 92, 93, 94, 112, 113, 114, 115, 116, 134, 135, 136, 137, 138, 156, 157, 158, 159, 160, 175, 176, 188, 206, 207, 208, 223, 224, 236, 251, 252, 253, 262, 263, 264, 277, 278, 296, 297, 298, 299, 300, 301

### Incorrect Method Signature

- **`graph/memstore/keys.go:528:16`**: `method Seek(k int64) (e *memstore.Enumerator, ok bool)` should have signature `Seek(int64, int) (int64, error)`

## `gocyclo` Results

The following functions have a cyclomatic complexity over 15:

| Complexity | Function                       | Location                                |
|------------|--------------------------------|-----------------------------------------|
| 61         | `graphql.iterateObject`        | `query/graphql/graphql.go:156:1`        |
| 46         | `shape.(Intersect).Optimize`   | `query/shape/shape.go:935:1`            |
| 40         | `linkedql.Unmarshal`           | `query/linkedql/registry.go:64:1`       |
| 38         | `schema.(*loader).loadIteratorToDepth` | `schema/loader.go:424:1`                |
| 36         | `schema.(*loader).loadToValue` | `schema/loader.go:293:1`                |
| 32         | `schema.(*loader).makePathForType` | `schema/loader.go:171:1`                |
| 31         | `repl.Repl`                    | `internal/repl/repl.go:92:1`            |
| 27         | `kv.(*QuadStore).ApplyDeltas`  | `graph/kv/indexing.go:563:1`            |
| 26         | `nosql.toQuadValue`            | `graph/nosql/quadstore.go:523:1`        |
| 25         | `schema.(*writer).writeAsQuads`| `schema/writer.go:116:1`                |
| 25         | `nosql.(*QuadStore).ApplyDeltas` | `graph/nosql/quadstore.go:378:1`        |
| 24         | `sql.(*QuadStore).ApplyDeltas` | `graph/sql/quadstore.go:384:1`          |
| 22         | `schema.(*Config).fieldRule`   | `schema/schema.go:130:1`                |
| 22         | `sexp.buildShape`              | `query/sexp/parser.go:203:1`            |
| 22         | `mql.(*Query).treeifyResult`   | `query/mql/fill.go:25:1`                |
| 22         | `internal.QuadReaderFor`       | `internal/load.go:45:1`                 |
| 22         | `sql.(*QuadStore).NameOf`      | `graph/sql/quadstore.go:603:1`          |
| 21         | `graphql.convField`            | `query/graphql/graphql.go:497:1`        |
| 20         | `shape.(NodesFrom).Optimize`   | `query/shape/shape.go:536:1`            |
| 20         | `gaedatastore.(*QuadStore).ApplyDeltas` | `graph/gaedatastore/quadstore.go:197:1` |
| 19         | `cayleyhttp.(*APIv2).ServeQuery` | `server/http/api_v2.go:495:1`           |
| 19         | `kv.(*allIteratorNext).Next`   | `graph/kv/all_iterator.go:131:1`        |
| 18         | `schema.(*writer).writeValueAs`| `schema/writer.go:61:1`                 |
| 18         | `sqlite.runTxSqlite`           | `graph/sql/sqlite/sqlite.go:57:1`       |
| 18         | `postgres.RunTx`               | `graph/sql/postgres/postgres.go:114:1`  |
| 18         | `mysql.runTxMysql`             | `graph/sql/mysql/mysql.go:45:1`         |
| 18         | `cockroach.runTxCockroach`     | `graph/sql/cockroach/cockroach.go:140:1`|
| 18         | `kv.(*QuadStore).flushMapBucket` | `graph/kv/indexing.go:976:1`            |
| 16         | `graphql.convValue`            | `query/graphql/graphql.go:563:1`        |
| 16         | `gizmo.cmpRegexp`              | `query/gizmo/environ.go:186:1`          |
| 16         | `sql.(*Optimizer).optimizeIntersect` | `graph/sql/optimizer.go:495:1`          |
| 16         | `kv.(*quadIteratorNext).Next`  | `graph/kv/quad_iterator.go:162:1`       |