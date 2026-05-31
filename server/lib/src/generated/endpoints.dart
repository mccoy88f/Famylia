/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/board_endpoint.dart' as _i2;
import '../endpoints/calendar_endpoint.dart' as _i3;
import '../endpoints/deadline_endpoint.dart' as _i4;
import '../endpoints/dev_endpoint.dart' as _i5;
import '../endpoints/document_endpoint.dart' as _i6;
import '../endpoints/emergency_endpoint.dart' as _i7;
import '../endpoints/expense_endpoint.dart' as _i8;
import '../endpoints/family_endpoint.dart' as _i9;
import '../endpoints/gamification_endpoint.dart' as _i10;
import '../endpoints/gdpr_endpoint.dart' as _i11;
import '../endpoints/health_endpoint.dart' as _i12;
import '../endpoints/location_endpoint.dart' as _i13;
import '../endpoints/meal_endpoint.dart' as _i14;
import '../endpoints/report_endpoint.dart' as _i15;
import '../endpoints/shopping_endpoint.dart' as _i16;
import '../endpoints/todo_endpoint.dart' as _i17;
import '../endpoints/ai_endpoint.dart' as _i45;
import 'package:famylia_server/src/generated/board_post_type.dart' as _i18;
import 'package:famylia_server/src/generated/calendar_event_category.dart'
    as _i19;
import 'package:famylia_server/src/generated/calendar_event.dart' as _i20;
import 'package:famylia_server/src/generated/deadline_category.dart' as _i21;
import 'package:famylia_server/src/generated/deadline_priority.dart' as _i22;
import 'package:famylia_server/src/generated/deadline_status.dart' as _i23;
import 'package:famylia_server/src/generated/deadline.dart' as _i24;
import 'package:famylia_server/src/generated/document_category.dart' as _i25;
import 'dart:typed_data' as _i26;
import 'package:famylia_server/src/generated/emergency_settings.dart' as _i27;
import 'package:famylia_server/src/generated/emergency_alert_type.dart' as _i28;
import 'package:famylia_server/src/generated/expense_category.dart' as _i29;
import 'package:famylia_server/src/generated/expense_split_type.dart' as _i30;
import 'package:famylia_server/src/generated/health_entry_type.dart' as _i31;
import 'package:famylia_server/src/generated/health_entry_status.dart' as _i32;
import 'package:famylia_server/src/generated/sport_intensity.dart' as _i33;
import 'package:famylia_server/src/generated/health_entry.dart' as _i34;
import 'package:famylia_server/src/generated/location_accuracy_level.dart'
    as _i35;
import 'package:famylia_server/src/generated/shopping_list_status.dart' as _i36;
import 'package:famylia_server/src/generated/shopping_unit.dart' as _i37;
import 'package:famylia_server/src/generated/shopping_category.dart' as _i38;
import 'package:famylia_server/src/generated/shopping_item.dart' as _i39;
import 'package:famylia_server/src/generated/todo_category.dart' as _i40;
import 'package:famylia_server/src/generated/todo_priority.dart' as _i41;
import 'package:famylia_server/src/generated/todo_status.dart' as _i42;
import 'package:famylia_server/src/generated/todo_item.dart' as _i43;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i44;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'board': _i2.BoardEndpoint()
        ..initialize(
          server,
          'board',
          null,
        ),
      'calendar': _i3.CalendarEndpoint()
        ..initialize(
          server,
          'calendar',
          null,
        ),
      'deadline': _i4.DeadlineEndpoint()
        ..initialize(
          server,
          'deadline',
          null,
        ),
      'dev': _i5.DevEndpoint()
        ..initialize(
          server,
          'dev',
          null,
        ),
      'document': _i6.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'emergency': _i7.EmergencyEndpoint()
        ..initialize(
          server,
          'emergency',
          null,
        ),
      'expense': _i8.ExpenseEndpoint()
        ..initialize(
          server,
          'expense',
          null,
        ),
      'family': _i9.FamilyEndpoint()
        ..initialize(
          server,
          'family',
          null,
        ),
      'gamification': _i10.GamificationEndpoint()
        ..initialize(
          server,
          'gamification',
          null,
        ),
      'gdpr': _i11.GdprEndpoint()
        ..initialize(
          server,
          'gdpr',
          null,
        ),
      'health': _i12.HealthEndpoint()
        ..initialize(
          server,
          'health',
          null,
        ),
      'location': _i13.LocationEndpoint()
        ..initialize(
          server,
          'location',
          null,
        ),
      'meal': _i14.MealEndpoint()
        ..initialize(
          server,
          'meal',
          null,
        ),
      'report': _i15.ReportEndpoint()
        ..initialize(
          server,
          'report',
          null,
        ),
      'shopping': _i16.ShoppingEndpoint()
        ..initialize(
          server,
          'shopping',
          null,
        ),
      'todo': _i17.TodoEndpoint()
        ..initialize(
          server,
          'todo',
          null,
        ),
      'ai': _i45.AiEndpoint()
        ..initialize(
          server,
          'ai',
          null,
        ),
    };
    connectors['board'] = _i1.EndpointConnector(
      name: 'board',
      endpoint: endpoints['board']!,
      methodConnectors: {
        'listPosts': _i1.MethodConnector(
          name: 'listPosts',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['board'] as _i2.BoardEndpoint).listPosts(
            session,
            params['familyId'],
          ),
        ),
        'createPost': _i1.MethodConnector(
          name: 'createPost',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i18.BoardPostType?>(),
              nullable: true,
            ),
            'pollOptions': _i1.ParameterDescription(
              name: 'pollOptions',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'isPinned': _i1.ParameterDescription(
              name: 'isPinned',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['board'] as _i2.BoardEndpoint).createPost(
            session,
            params['familyId'],
            params['content'],
            title: params['title'],
            type: params['type'],
            pollOptions: params['pollOptions'],
            isPinned: params['isPinned'],
          ),
        ),
        'votePoll': _i1.MethodConnector(
          name: 'votePoll',
          params: {
            'optionId': _i1.ParameterDescription(
              name: 'optionId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['board'] as _i2.BoardEndpoint).votePoll(
            session,
            params['optionId'],
          ),
        ),
        'deletePost': _i1.MethodConnector(
          name: 'deletePost',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['board'] as _i2.BoardEndpoint).deletePost(
            session,
            params['postId'],
          ),
        ),
        'watchBoard': _i1.MethodStreamConnector(
          name: 'watchBoard',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['board'] as _i2.BoardEndpoint).watchBoard(
            session,
            params['familyId'],
          ),
        ),
      },
    );
    connectors['calendar'] = _i1.EndpointConnector(
      name: 'calendar',
      endpoint: endpoints['calendar']!,
      methodConnectors: {
        'createEvent': _i1.MethodConnector(
          name: 'createEvent',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'startAt': _i1.ParameterDescription(
              name: 'startAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i19.CalendarEventCategory?>(),
              nullable: true,
            ),
            'endAt': _i1.ParameterDescription(
              name: 'endAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'isAllDay': _i1.ParameterDescription(
              name: 'isAllDay',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'assignedTo': _i1.ParameterDescription(
              name: 'assignedTo',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isPrivate': _i1.ParameterDescription(
              name: 'isPrivate',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'color': _i1.ParameterDescription(
              name: 'color',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['calendar'] as _i3.CalendarEndpoint).createEvent(
            session,
            params['familyId'],
            params['title'],
            params['startAt'],
            description: params['description'],
            category: params['category'],
            endAt: params['endAt'],
            isAllDay: params['isAllDay'],
            location: params['location'],
            assignedTo: params['assignedTo'],
            isPrivate: params['isPrivate'],
            color: params['color'],
          ),
        ),
        'listEvents': _i1.MethodConnector(
          name: 'listEvents',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['calendar'] as _i3.CalendarEndpoint).listEvents(
            session,
            params['familyId'],
            params['from'],
            params['to'],
          ),
        ),
        'updateEvent': _i1.MethodConnector(
          name: 'updateEvent',
          params: {
            'event': _i1.ParameterDescription(
              name: 'event',
              type: _i1.getType<_i20.CalendarEvent>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['calendar'] as _i3.CalendarEndpoint).updateEvent(
            session,
            params['event'],
          ),
        ),
        'deleteEvent': _i1.MethodConnector(
          name: 'deleteEvent',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['calendar'] as _i3.CalendarEndpoint).deleteEvent(
            session,
            params['eventId'],
          ),
        ),
      },
    );
    connectors['deadline'] = _i1.EndpointConnector(
      name: 'deadline',
      endpoint: endpoints['deadline']!,
      methodConnectors: {
        'createDeadline': _i1.MethodConnector(
          name: 'createDeadline',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i21.DeadlineCategory?>(),
              nullable: true,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<_i22.DeadlinePriority?>(),
              nullable: true,
            ),
            'assignedTo': _i1.ParameterDescription(
              name: 'assignedTo',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isPrivate': _i1.ParameterDescription(
              name: 'isPrivate',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'isRecurring': _i1.ParameterDescription(
              name: 'isRecurring',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'recurrenceRule': _i1.ParameterDescription(
              name: 'recurrenceRule',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['deadline'] as _i4.DeadlineEndpoint).createDeadline(
            session,
            params['familyId'],
            params['title'],
            params['dueDate'],
            description: params['description'],
            category: params['category'],
            amount: params['amount'],
            priority: params['priority'],
            assignedTo: params['assignedTo'],
            isPrivate: params['isPrivate'],
            isRecurring: params['isRecurring'],
            recurrenceRule: params['recurrenceRule'],
          ),
        ),
        'listDeadlines': _i1.MethodConnector(
          name: 'listDeadlines',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i23.DeadlineStatus?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i21.DeadlineCategory?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['deadline'] as _i4.DeadlineEndpoint).listDeadlines(
            session,
            params['familyId'],
            status: params['status'],
            category: params['category'],
          ),
        ),
        'upcoming': _i1.MethodConnector(
          name: 'upcoming',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'days': _i1.ParameterDescription(
              name: 'days',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['deadline'] as _i4.DeadlineEndpoint).upcoming(
            session,
            params['familyId'],
            days: params['days'],
          ),
        ),
        'completeDeadline': _i1.MethodConnector(
          name: 'completeDeadline',
          params: {
            'deadlineId': _i1.ParameterDescription(
              name: 'deadlineId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['deadline'] as _i4.DeadlineEndpoint).completeDeadline(
            session,
            params['deadlineId'],
          ),
        ),
        'updateDeadline': _i1.MethodConnector(
          name: 'updateDeadline',
          params: {
            'deadline': _i1.ParameterDescription(
              name: 'deadline',
              type: _i1.getType<_i24.Deadline>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['deadline'] as _i4.DeadlineEndpoint).updateDeadline(
            session,
            params['deadline'],
          ),
        ),
        'deleteDeadline': _i1.MethodConnector(
          name: 'deleteDeadline',
          params: {
            'deadlineId': _i1.ParameterDescription(
              name: 'deadlineId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['deadline'] as _i4.DeadlineEndpoint).deleteDeadline(
            session,
            params['deadlineId'],
          ),
        ),
      },
    );
    connectors['dev'] = _i1.EndpointConnector(
      name: 'dev',
      endpoint: endpoints['dev']!,
      methodConnectors: {
        'getVerificationCode': _i1.MethodConnector(
          name: 'getVerificationCode',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dev'] as _i5.DevEndpoint).getVerificationCode(
            session,
            params['email'],
          ),
        )
      },
    );
    connectors['document'] = _i1.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'listDocuments': _i1.MethodConnector(
          name: 'listDocuments',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i25.DocumentCategory?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i6.DocumentEndpoint).listDocuments(
            session,
            params['familyId'],
            category: params['category'],
          ),
        ),
        'uploadDocument': _i1.MethodConnector(
          name: 'uploadDocument',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fileBytes': _i1.ParameterDescription(
              name: 'fileBytes',
              type: _i1.getType<_i26.ByteData>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i25.DocumentCategory?>(),
              nullable: true,
            ),
            'relatedDeadlineId': _i1.ParameterDescription(
              name: 'relatedDeadlineId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'relatedExpenseId': _i1.ParameterDescription(
              name: 'relatedExpenseId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i6.DocumentEndpoint).uploadDocument(
            session,
            params['familyId'],
            params['title'],
            params['fileName'],
            params['fileBytes'],
            description: params['description'],
            category: params['category'],
            relatedDeadlineId: params['relatedDeadlineId'],
            relatedExpenseId: params['relatedExpenseId'],
          ),
        ),
        'runOcr': _i1.MethodConnector(
          name: 'runOcr',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i6.DocumentEndpoint).runOcr(
            session,
            params['documentId'],
          ),
        ),
        'deleteDocument': _i1.MethodConnector(
          name: 'deleteDocument',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i6.DocumentEndpoint).deleteDocument(
            session,
            params['documentId'],
          ),
        ),
      },
    );
    connectors['emergency'] = _i1.EndpointConnector(
      name: 'emergency',
      endpoint: endpoints['emergency']!,
      methodConnectors: {
        'getSettings': _i1.MethodConnector(
          name: 'getSettings',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).getSettings(
            session,
            params['familyId'],
          ),
        ),
        'updateSettings': _i1.MethodConnector(
          name: 'updateSettings',
          params: {
            'settings': _i1.ParameterDescription(
              name: 'settings',
              type: _i1.getType<_i27.EmergencySettings>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).updateSettings(
            session,
            params['settings'],
          ),
        ),
        'triggerAlert': _i1.MethodConnector(
          name: 'triggerAlert',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'alertType': _i1.ParameterDescription(
              name: 'alertType',
              type: _i1.getType<_i28.EmergencyAlertType>(),
              nullable: false,
            ),
            'customMessage': _i1.ParameterDescription(
              name: 'customMessage',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'locationLat': _i1.ParameterDescription(
              name: 'locationLat',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'locationLng': _i1.ParameterDescription(
              name: 'locationLng',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'locationAddress': _i1.ParameterDescription(
              name: 'locationAddress',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'batteryLevel': _i1.ParameterDescription(
              name: 'batteryLevel',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isTest': _i1.ParameterDescription(
              name: 'isTest',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).triggerAlert(
            session,
            params['familyId'],
            params['alertType'],
            customMessage: params['customMessage'],
            locationLat: params['locationLat'],
            locationLng: params['locationLng'],
            locationAddress: params['locationAddress'],
            batteryLevel: params['batteryLevel'],
            isTest: params['isTest'],
          ),
        ),
        'listActive': _i1.MethodConnector(
          name: 'listActive',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).listActive(
            session,
            params['familyId'],
          ),
        ),
        'listHistory': _i1.MethodConnector(
          name: 'listHistory',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).listHistory(
            session,
            params['familyId'],
          ),
        ),
        'acknowledge': _i1.MethodConnector(
          name: 'acknowledge',
          params: {
            'alertId': _i1.ParameterDescription(
              name: 'alertId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).acknowledge(
            session,
            params['alertId'],
          ),
        ),
        'resolve': _i1.MethodConnector(
          name: 'resolve',
          params: {
            'alertId': _i1.ParameterDescription(
              name: 'alertId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).resolve(
            session,
            params['alertId'],
          ),
        ),
        'markFalseAlarm': _i1.MethodConnector(
          name: 'markFalseAlarm',
          params: {
            'alertId': _i1.ParameterDescription(
              name: 'alertId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).markFalseAlarm(
            session,
            params['alertId'],
          ),
        ),
        'listContacts': _i1.MethodConnector(
          name: 'listContacts',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).listContacts(
            session,
            params['familyId'],
          ),
        ),
        'addContact': _i1.MethodConnector(
          name: 'addContact',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).addContact(
            session,
            params['familyId'],
            params['name'],
            params['phone'],
            email: params['email'],
            priority: params['priority'],
          ),
        ),
        'deleteContact': _i1.MethodConnector(
          name: 'deleteContact',
          params: {
            'contactId': _i1.ParameterDescription(
              name: 'contactId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).deleteContact(
            session,
            params['contactId'],
          ),
        ),
        'watchAlerts': _i1.MethodStreamConnector(
          name: 'watchAlerts',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['emergency'] as _i7.EmergencyEndpoint).watchAlerts(
            session,
            params['familyId'],
          ),
        ),
      },
    );
    connectors['expense'] = _i1.EndpointConnector(
      name: 'expense',
      endpoint: endpoints['expense']!,
      methodConnectors: {
        'createExpense': _i1.MethodConnector(
          name: 'createExpense',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'paidBy': _i1.ParameterDescription(
              name: 'paidBy',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i29.ExpenseCategory?>(),
              nullable: true,
            ),
            'splitType': _i1.ParameterDescription(
              name: 'splitType',
              type: _i1.getType<_i30.ExpenseSplitType?>(),
              nullable: true,
            ),
            'splitDetailsJson': _i1.ParameterDescription(
              name: 'splitDetailsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'expenseDate': _i1.ParameterDescription(
              name: 'expenseDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['expense'] as _i8.ExpenseEndpoint).createExpense(
            session,
            params['familyId'],
            params['title'],
            params['amount'],
            params['paidBy'],
            description: params['description'],
            category: params['category'],
            splitType: params['splitType'],
            splitDetailsJson: params['splitDetailsJson'],
            expenseDate: params['expenseDate'],
          ),
        ),
        'listExpenses': _i1.MethodConnector(
          name: 'listExpenses',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['expense'] as _i8.ExpenseEndpoint).listExpenses(
            session,
            params['familyId'],
            from: params['from'],
            to: params['to'],
          ),
        ),
        'getBalance': _i1.MethodConnector(
          name: 'getBalance',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['expense'] as _i8.ExpenseEndpoint).getBalance(
            session,
            params['familyId'],
          ),
        ),
        'recordSettlement': _i1.MethodConnector(
          name: 'recordSettlement',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fromUserId': _i1.ParameterDescription(
              name: 'fromUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'toUserId': _i1.ParameterDescription(
              name: 'toUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['expense'] as _i8.ExpenseEndpoint).recordSettlement(
            session,
            params['familyId'],
            params['fromUserId'],
            params['toUserId'],
            params['amount'],
          ),
        ),
        'listSettlements': _i1.MethodConnector(
          name: 'listSettlements',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['expense'] as _i8.ExpenseEndpoint).listSettlements(
            session,
            params['familyId'],
          ),
        ),
        'deleteExpense': _i1.MethodConnector(
          name: 'deleteExpense',
          params: {
            'expenseId': _i1.ParameterDescription(
              name: 'expenseId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['expense'] as _i8.ExpenseEndpoint).deleteExpense(
            session,
            params['expenseId'],
          ),
        ),
      },
    );
    connectors['family'] = _i1.EndpointConnector(
      name: 'family',
      endpoint: endpoints['family']!,
      methodConnectors: {
        'createFamily': _i1.MethodConnector(
          name: 'createFamily',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['family'] as _i9.FamilyEndpoint).createFamily(
            session,
            params['name'],
          ),
        ),
        'joinFamily': _i1.MethodConnector(
          name: 'joinFamily',
          params: {
            'inviteCode': _i1.ParameterDescription(
              name: 'inviteCode',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['family'] as _i9.FamilyEndpoint).joinFamily(
            session,
            params['inviteCode'],
          ),
        ),
        'listMyFamilies': _i1.MethodConnector(
          name: 'listMyFamilies',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['family'] as _i9.FamilyEndpoint)
                  .listMyFamilies(session),
        ),
        'getFamily': _i1.MethodConnector(
          name: 'getFamily',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['family'] as _i9.FamilyEndpoint).getFamily(
            session,
            params['familyId'],
          ),
        ),
        'listMembers': _i1.MethodConnector(
          name: 'listMembers',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['family'] as _i9.FamilyEndpoint).listMembers(
            session,
            params['familyId'],
          ),
        ),
        'updateAccentColor': _i1.MethodConnector(
          name: 'updateAccentColor',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'accentColor': _i1.ParameterDescription(
              name: 'accentColor',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['family'] as _i9.FamilyEndpoint).updateAccentColor(
            session,
            params['familyId'],
            params['accentColor'],
          ),
        ),
        'leaveFamily': _i1.MethodConnector(
          name: 'leaveFamily',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['family'] as _i9.FamilyEndpoint).leaveFamily(
            session,
            params['familyId'],
          ),
        ),
      },
    );
    connectors['gamification'] = _i1.EndpointConnector(
      name: 'gamification',
      endpoint: endpoints['gamification']!,
      methodConnectors: {
        'getMyPoints': _i1.MethodConnector(
          name: 'getMyPoints',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gamification'] as _i10.GamificationEndpoint)
                  .getMyPoints(
            session,
            params['familyId'],
          ),
        ),
        'getLeaderboard': _i1.MethodConnector(
          name: 'getLeaderboard',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gamification'] as _i10.GamificationEndpoint)
                  .getLeaderboard(
            session,
            params['familyId'],
          ),
        ),
      },
    );
    connectors['gdpr'] = _i1.EndpointConnector(
      name: 'gdpr',
      endpoint: endpoints['gdpr']!,
      methodConnectors: {
        'exportMyData': _i1.MethodConnector(
          name: 'exportMyData',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gdpr'] as _i11.GdprEndpoint).exportMyData(session),
        ),
        'deleteMyAccount': _i1.MethodConnector(
          name: 'deleteMyAccount',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gdpr'] as _i11.GdprEndpoint).deleteMyAccount(session),
        ),
        'getPrivacyDashboard': _i1.MethodConnector(
          name: 'getPrivacyDashboard',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gdpr'] as _i11.GdprEndpoint).getPrivacyDashboard(
            session,
            params['familyId'],
          ),
        ),
      },
    );
    connectors['health'] = _i1.EndpointConnector(
      name: 'health',
      endpoint: endpoints['health']!,
      methodConnectors: {
        'createEntry': _i1.MethodConnector(
          name: 'createEntry',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i31.HealthEntryType>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.HealthEntryStatus?>(),
              nullable: true,
            ),
            'assignedTo': _i1.ParameterDescription(
              name: 'assignedTo',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endAt': _i1.ParameterDescription(
              name: 'endAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'providerName': _i1.ParameterDescription(
              name: 'providerName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'dietGoal': _i1.ParameterDescription(
              name: 'dietGoal',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'caloriesTarget': _i1.ParameterDescription(
              name: 'caloriesTarget',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'sportType': _i1.ParameterDescription(
              name: 'sportType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'intensity': _i1.ParameterDescription(
              name: 'intensity',
              type: _i1.getType<_i33.SportIntensity?>(),
              nullable: true,
            ),
            'isPrivate': _i1.ParameterDescription(
              name: 'isPrivate',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['health'] as _i12.HealthEndpoint).createEntry(
            session,
            params['familyId'],
            params['type'],
            params['title'],
            description: params['description'],
            status: params['status'],
            assignedTo: params['assignedTo'],
            scheduledAt: params['scheduledAt'],
            endAt: params['endAt'],
            providerName: params['providerName'],
            location: params['location'],
            dietGoal: params['dietGoal'],
            caloriesTarget: params['caloriesTarget'],
            sportType: params['sportType'],
            durationMinutes: params['durationMinutes'],
            intensity: params['intensity'],
            isPrivate: params['isPrivate'],
          ),
        ),
        'listEntries': _i1.MethodConnector(
          name: 'listEntries',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i31.HealthEntryType?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.HealthEntryStatus?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['health'] as _i12.HealthEndpoint).listEntries(
            session,
            params['familyId'],
            type: params['type'],
            status: params['status'],
          ),
        ),
        'upcoming': _i1.MethodConnector(
          name: 'upcoming',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'days': _i1.ParameterDescription(
              name: 'days',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i31.HealthEntryType?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['health'] as _i12.HealthEndpoint).upcoming(
            session,
            params['familyId'],
            days: params['days'],
            type: params['type'],
          ),
        ),
        'updateEntry': _i1.MethodConnector(
          name: 'updateEntry',
          params: {
            'entry': _i1.ParameterDescription(
              name: 'entry',
              type: _i1.getType<_i34.HealthEntry>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['health'] as _i12.HealthEndpoint).updateEntry(
            session,
            params['entry'],
          ),
        ),
        'completeEntry': _i1.MethodConnector(
          name: 'completeEntry',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['health'] as _i12.HealthEndpoint).completeEntry(
            session,
            params['entryId'],
          ),
        ),
        'deleteEntry': _i1.MethodConnector(
          name: 'deleteEntry',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['health'] as _i12.HealthEndpoint).deleteEntry(
            session,
            params['entryId'],
          ),
        ),
      },
    );
    connectors['location'] = _i1.EndpointConnector(
      name: 'location',
      endpoint: endpoints['location']!,
      methodConnectors: {
        'getStatus': _i1.MethodConnector(
          name: 'getStatus',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i13.LocationEndpoint).getStatus(
            session,
            params['familyId'],
          ),
        ),
        'updateStatus': _i1.MethodConnector(
          name: 'updateStatus',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isEnabled': _i1.ParameterDescription(
              name: 'isEnabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'accuracyLevel': _i1.ParameterDescription(
              name: 'accuracyLevel',
              type: _i1.getType<_i35.LocationAccuracyLevel?>(),
              nullable: true,
            ),
            'autoDisableAfterHours': _i1.ParameterDescription(
              name: 'autoDisableAfterHours',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i13.LocationEndpoint).updateStatus(
            session,
            params['familyId'],
            params['isEnabled'],
            accuracyLevel: params['accuracyLevel'],
            autoDisableAfterHours: params['autoDisableAfterHours'],
          ),
        ),
        'checkIn': _i1.MethodConnector(
          name: 'checkIn',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'accuracyMeters': _i1.ParameterDescription(
              name: 'accuracyMeters',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'address': _i1.ParameterDescription(
              name: 'address',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'batteryLevel': _i1.ParameterDescription(
              name: 'batteryLevel',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i13.LocationEndpoint).checkIn(
            session,
            params['familyId'],
            params['latitude'],
            params['longitude'],
            accuracyMeters: params['accuracyMeters'],
            address: params['address'],
            batteryLevel: params['batteryLevel'],
          ),
        ),
        'getFamilyLocations': _i1.MethodConnector(
          name: 'getFamilyLocations',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i13.LocationEndpoint)
                  .getFamilyLocations(
            session,
            params['familyId'],
          ),
        ),
        'listSafeZones': _i1.MethodConnector(
          name: 'listSafeZones',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i13.LocationEndpoint).listSafeZones(
            session,
            params['familyId'],
          ),
        ),
        'createSafeZone': _i1.MethodConnector(
          name: 'createSafeZone',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusMeters': _i1.ParameterDescription(
              name: 'radiusMeters',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i13.LocationEndpoint).createSafeZone(
            session,
            params['familyId'],
            params['name'],
            params['latitude'],
            params['longitude'],
            radiusMeters: params['radiusMeters'],
          ),
        ),
      },
    );
    connectors['meal'] = _i1.EndpointConnector(
      name: 'meal',
      endpoint: endpoints['meal']!,
      methodConnectors: {
        'createRecipe': _i1.MethodConnector(
          name: 'createRecipe',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'ingredientsJson': _i1.ParameterDescription(
              name: 'ingredientsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'servings': _i1.ParameterDescription(
              name: 'servings',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['meal'] as _i14.MealEndpoint).createRecipe(
            session,
            params['familyId'],
            params['title'],
            description: params['description'],
            ingredientsJson: params['ingredientsJson'],
            servings: params['servings'],
          ),
        ),
        'listRecipes': _i1.MethodConnector(
          name: 'listRecipes',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['meal'] as _i14.MealEndpoint).listRecipes(
            session,
            params['familyId'],
          ),
        ),
        'saveMealPlan': _i1.MethodConnector(
          name: 'saveMealPlan',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'weekStart': _i1.ParameterDescription(
              name: 'weekStart',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'mealsJson': _i1.ParameterDescription(
              name: 'mealsJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['meal'] as _i14.MealEndpoint).saveMealPlan(
            session,
            params['familyId'],
            params['weekStart'],
            params['mealsJson'],
          ),
        ),
        'getMealPlan': _i1.MethodConnector(
          name: 'getMealPlan',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'weekStart': _i1.ParameterDescription(
              name: 'weekStart',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['meal'] as _i14.MealEndpoint).getMealPlan(
            session,
            params['familyId'],
            params['weekStart'],
          ),
        ),
        'shoppingItemsFromPlan': _i1.MethodConnector(
          name: 'shoppingItemsFromPlan',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'weekStart': _i1.ParameterDescription(
              name: 'weekStart',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['meal'] as _i14.MealEndpoint).shoppingItemsFromPlan(
            session,
            params['familyId'],
            params['weekStart'],
          ),
        ),
        'applyDietToMealPlan': _i1.MethodConnector(
          name: 'applyDietToMealPlan',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'weekStart': _i1.ParameterDescription(
              name: 'weekStart',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'healthEntryId': _i1.ParameterDescription(
              name: 'healthEntryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['meal'] as _i14.MealEndpoint).applyDietToMealPlan(
            session,
            params['familyId'],
            params['weekStart'],
            params['healthEntryId'],
          ),
        ),
      },
    );
    connectors['report'] = _i1.EndpointConnector(
      name: 'report',
      endpoint: endpoints['report']!,
      methodConnectors: {
        'getReport': _i1.MethodConnector(
          name: 'getReport',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['report'] as _i15.ReportEndpoint).getReport(
            session,
            params['familyId'],
          ),
        )
      },
    );
    connectors['shopping'] = _i1.EndpointConnector(
      name: 'shopping',
      endpoint: endpoints['shopping']!,
      methodConnectors: {
        'createList': _i1.MethodConnector(
          name: 'createList',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'store': _i1.ParameterDescription(
              name: 'store',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'assignedTo': _i1.ParameterDescription(
              name: 'assignedTo',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).createList(
            session,
            params['familyId'],
            params['name'],
            store: params['store'],
            assignedTo: params['assignedTo'],
            dueDate: params['dueDate'],
          ),
        ),
        'listLists': _i1.MethodConnector(
          name: 'listLists',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i36.ShoppingListStatus?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).listLists(
            session,
            params['familyId'],
            status: params['status'],
          ),
        ),
        'getList': _i1.MethodConnector(
          name: 'getList',
          params: {
            'listId': _i1.ParameterDescription(
              name: 'listId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).getList(
            session,
            params['listId'],
          ),
        ),
        'addItem': _i1.MethodConnector(
          name: 'addItem',
          params: {
            'listId': _i1.ParameterDescription(
              name: 'listId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'quantity': _i1.ParameterDescription(
              name: 'quantity',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'unit': _i1.ParameterDescription(
              name: 'unit',
              type: _i1.getType<_i37.ShoppingUnit?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i38.ShoppingCategory?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isUrgent': _i1.ParameterDescription(
              name: 'isUrgent',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).addItem(
            session,
            params['listId'],
            params['name'],
            quantity: params['quantity'],
            unit: params['unit'],
            category: params['category'],
            notes: params['notes'],
            isUrgent: params['isUrgent'],
          ),
        ),
        'updateItem': _i1.MethodConnector(
          name: 'updateItem',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i39.ShoppingItem>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).updateItem(
            session,
            params['item'],
          ),
        ),
        'checkItem': _i1.MethodConnector(
          name: 'checkItem',
          params: {
            'itemId': _i1.ParameterDescription(
              name: 'itemId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isChecked': _i1.ParameterDescription(
              name: 'isChecked',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).checkItem(
            session,
            params['itemId'],
            params['isChecked'],
          ),
        ),
        'deleteItem': _i1.MethodConnector(
          name: 'deleteItem',
          params: {
            'itemId': _i1.ParameterDescription(
              name: 'itemId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).deleteItem(
            session,
            params['itemId'],
          ),
        ),
        'completeList': _i1.MethodConnector(
          name: 'completeList',
          params: {
            'listId': _i1.ParameterDescription(
              name: 'listId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).completeList(
            session,
            params['listId'],
          ),
        ),
        'watchList': _i1.MethodStreamConnector(
          name: 'watchList',
          params: {
            'listId': _i1.ParameterDescription(
              name: 'listId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['shopping'] as _i16.ShoppingEndpoint).watchList(
            session,
            params['listId'],
          ),
        ),
      },
    );
    connectors['todo'] = _i1.EndpointConnector(
      name: 'todo',
      endpoint: endpoints['todo']!,
      methodConnectors: {
        'createTodo': _i1.MethodConnector(
          name: 'createTodo',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i40.TodoCategory?>(),
              nullable: true,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<_i41.TodoPriority?>(),
              nullable: true,
            ),
            'assignedTo': _i1.ParameterDescription(
              name: 'assignedTo',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todo'] as _i17.TodoEndpoint).createTodo(
            session,
            params['familyId'],
            params['title'],
            description: params['description'],
            category: params['category'],
            priority: params['priority'],
            assignedTo: params['assignedTo'],
            dueDate: params['dueDate'],
          ),
        ),
        'listTodos': _i1.MethodConnector(
          name: 'listTodos',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i42.TodoStatus?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todo'] as _i17.TodoEndpoint).listTodos(
            session,
            params['familyId'],
            status: params['status'],
          ),
        ),
        'myDay': _i1.MethodConnector(
          name: 'myDay',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todo'] as _i17.TodoEndpoint).myDay(
            session,
            params['familyId'],
          ),
        ),
        'assignTodo': _i1.MethodConnector(
          name: 'assignTodo',
          params: {
            'todoId': _i1.ParameterDescription(
              name: 'todoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'assignedTo': _i1.ParameterDescription(
              name: 'assignedTo',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todo'] as _i17.TodoEndpoint).assignTodo(
            session,
            params['todoId'],
            params['assignedTo'],
          ),
        ),
        'updateTodo': _i1.MethodConnector(
          name: 'updateTodo',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i43.TodoItem>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todo'] as _i17.TodoEndpoint).updateTodo(
            session,
            params['item'],
          ),
        ),
        'completeTodo': _i1.MethodConnector(
          name: 'completeTodo',
          params: {
            'todoId': _i1.ParameterDescription(
              name: 'todoId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todo'] as _i17.TodoEndpoint).completeTodo(
            session,
            params['todoId'],
          ),
        ),
        'deleteTodo': _i1.MethodConnector(
          name: 'deleteTodo',
          params: {
            'todoId': _i1.ParameterDescription(
              name: 'todoId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todo'] as _i17.TodoEndpoint).deleteTodo(
            session,
            params['todoId'],
          ),
        ),
      },
    );
    connectors['ai'] = _i1.EndpointConnector(
      name: 'ai',
      endpoint: endpoints['ai']!,
      methodConnectors: {
        'isConfigured': _i1.MethodConnector(
          name: 'isConfigured',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i45.AiEndpoint).isConfigured(session),
        ),
        'getAiConfig': _i1.MethodConnector(
          name: 'getAiConfig',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i45.AiEndpoint).getAiConfig(session),
        ),
        'saveAiConfig': _i1.MethodConnector(
          name: 'saveAiConfig',
          params: {
            'openRouterApiKey': _i1.ParameterDescription(
              name: 'openRouterApiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'defaultModel': _i1.ParameterDescription(
              name: 'defaultModel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i45.AiEndpoint).saveAiConfig(
            session,
            params['openRouterApiKey'],
            params['defaultModel'],
          ),
        ),
        'extractActivity': _i1.MethodConnector(
          name: 'extractActivity',
          params: {
            'familyId': _i1.ParameterDescription(
              name: 'familyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'payload': _i1.ParameterDescription(
              name: 'payload',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i45.AiEndpoint).extractActivity(
            session,
            params['familyId'],
            params['payload'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i44.Endpoints()..initializeEndpoints(server);
  }
}
