import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import '../resource/resource.dart';

/// https://opentelemetry.io/docs/specs/otel/logs/sdk/#readablelogrecord
abstract class ReadableLogRecord {
  DateTime? get timestamp;

  DateTime? get observedTimestamp;

  String? get severityText;

  SeverityNumber? get severityNumber;

  dynamic get body;

  Attributes? get attributes;

  TraceId? get traceId;

  SpanId? get spanId;

  TraceFlags? get traceFlags;

  String? get eventName;

  InstrumentationScope get instrumentationScope;

  Resource? get resource;
}

/// https://opentelemetry.io/docs/specs/otel/logs/sdk/#readwritelogrecord
abstract class ReadWriteLogRecord implements ReadableLogRecord {
  set timestamp(DateTime? value);

  set observedTimestamp(DateTime? value);

  set severityText(String? value);

  set severityNumber(SeverityNumber? value);

  set body(dynamic value);

  set traceId(TraceId? value);

  set spanId(SpanId? value);

  set traceFlags(TraceFlags? value);

  set eventName(String? value);

  void setAttributes(Attributes? attribute);

  void removeAttribute(String key);

  void clearAttributes();

  ReadWriteLogRecord clone();
}

class LogRecord implements ReadWriteLogRecord {
  @override
  DateTime? timestamp;

  @override
  DateTime? observedTimestamp;

  @override
  String? severityText;

  @override
  SeverityNumber? severityNumber;

  @override
  dynamic body;

  @override
  Attributes? attributes;

  @override
  TraceId? traceId;

  @override
  SpanId? spanId;

  @override
  TraceFlags? traceFlags;

  @override
  String? eventName;

  @override
  final InstrumentationScope instrumentationScope;

  @override
  final Resource? resource;

  LogRecord({
    this.timestamp,
    this.observedTimestamp,
    this.severityText,
    this.severityNumber,
    this.body,
    Attributes? attributes,
    this.traceId,
    this.spanId,
    this.traceFlags,
    this.eventName,
    required this.instrumentationScope,
    required this.resource,
  }) : attributes = attributes ?? Attributes.of({});

  @override
  void setAttributes(Attributes? attributes) {
    if (attributes == null) return;
    this.attributes?.copyWithAttributes(attributes);
  }

  @override
  void removeAttribute(String key) {
    attributes?.copyWithout(key);
  }

  @override
  void clearAttributes() {
    attributes?.keys.map((key) {
      attributes?.copyWithout(key);
    });
  }

  @override
  LogRecord clone() {
    return LogRecord(
      timestamp: timestamp,
      observedTimestamp: observedTimestamp,
      severityText: severityText,
      severityNumber: severityNumber,
      body: body,
      attributes: attributes?.copyWith([]),
      traceId: traceId,
      spanId: spanId,
      traceFlags: traceFlags,
      eventName: eventName,
      instrumentationScope: instrumentationScope,
      resource: resource,
    );
  }

  @override
  String toString() {
    return 'LogRecord('
        'timestamp: $timestamp, '
        'severityText: $severityText, '
        'body: $body, '
        'traceId: $traceId, '
        'spanId: $spanId'
        ')';
  }
}
