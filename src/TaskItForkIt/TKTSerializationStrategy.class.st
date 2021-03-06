"
ForkIt protocol of communication runs on top of http. 
For message passing (via post) using a multipart entity. 
a request has then two parts: 

A string part that state the serializer to use, and a serialized field ""content"".  

By default, the code proposes to respond messages using the same serializer, but in any case, what ever serializer can be used.
"
Class {
	#name : #TKTSerializationStrategy,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'TaskItForkIt-Worker-Server'
}

{ #category : #'as yet unclassified' }
TKTSerializationStrategy class >> default [
	^ default ifNil: [ ^ self xstoned ] .
]

{ #category : #'as yet unclassified' }
TKTSerializationStrategy class >> default: aDefault [
	default := aDefault
]

{ #category : #'as yet unclassified' }
TKTSerializationStrategy class >> fuel [
	^ TKTFuelSerializationStrategy new
]

{ #category : #'as yet unclassified' }
TKTSerializationStrategy class >> resolveSerializer: aName [
	aName = #fuel ifTrue: [ ^ self fuel ].
	aName = #ston ifTrue: [ ^ self ston ].
	aName = #xstoned ifTrue: [ ^ self xstoned ].
]

{ #category : #'as yet unclassified' }
TKTSerializationStrategy class >> ston [ 
	^ TKTStonSerializationStrategy new
]

{ #category : #'as yet unclassified' }
TKTSerializationStrategy class >> xstoned [ 
	^ TKTXStonedSerializationStrategy new
]

{ #category : #writing }
TKTSerializationStrategy >> privateDecodeContent: aZnEntity [
	self subclassResponsibility 
]

{ #category : #writing }
TKTSerializationStrategy >> privateEncodeContent: aContent [
	self subclassResponsibility 
]

{ #category : #writing }
TKTSerializationStrategy >> readFromZnEntity: aRequestEntity [
	^ (self class
		resolveSerializer: (aRequestEntity partNamed: 'serializer') fieldValue)
		privateDecodeContent: (aRequestEntity partNamed: 'content') entity
]

{ #category : #writing }
TKTSerializationStrategy >> readFromZnRequest: aRequestEntity [
	^ aRequestEntity entity
		ifNotNil: [ self readFromZnEntity: aRequestEntity entity ]
]

{ #category : #writing }
TKTSerializationStrategy >> readFromZnResponse: aResponseEntity [
	aResponseEntity isError
		ifTrue: [ self error: ' REMOTE ERROR: ' , aResponseEntity entity string ].
	^ aResponseEntity entity
		ifNotNil: [ self readFromZnEntity: aResponseEntity entity ]
]

{ #category : #writing }
TKTSerializationStrategy >> selector [
	self subclassResponsibility 
]

{ #category : #writing }
TKTSerializationStrategy >> serializerFor: aRequestEntity [
	^ aRequestEntity
		ifNil: [ self class default ]
		ifNotNil: [ self class
				resolveSerializer: (aRequestEntity partNamed: 'serializer') fieldValue ]
]

{ #category : #writing }
TKTSerializationStrategy >> writeZnEntityFor: aValue [
	^ ZnMultiPartFormDataEntity new
		addPart: (ZnMimePart fieldName: 'serializer' value: self selector);
		addPart:
			(ZnMimePart
				fieldName: 'content'
				entity: (self privateEncodeContent: aValue));
		yourself
]

{ #category : #writing }
TKTSerializationStrategy >> writeZnRequestFor: aValue to: anUrl [
	^ self
		readFromZnResponse: (ZnEasy post: anUrl data: (self writeZnEntityFor: aValue))
]
