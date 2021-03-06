"
An archetyped task is like a regular task, but it has an archetype. This archetype is used to select the kind of runner that can respond to this task.
"
Class {
	#name : #TKTArchetypedTask,
	#superclass : #TKTGenericTask,
	#instVars : [
		'archetype',
		'serializer',
		'serializerSelector'
	],
	#category : #'TaskItForkIt-Task'
}

{ #category : #accessing }
TKTArchetypedTask >> archetype [
	^ archetype
]

{ #category : #accessing }
TKTArchetypedTask >> archetype: aTKTArchetype [ 
	archetype := aTKTArchetype
]

{ #category : #accessing }
TKTArchetypedTask >> future: executor [
	^ executor futureArchetypedTask: self
]

{ #category : #accessing }
TKTArchetypedTask >> futureTaskExecutionFor: aRunner [
	^ self
		configureTaskExecution: TKTRemoteTaskExecution new
		with: aRunner
]

{ #category : #accessing }
TKTArchetypedTask >> initialize [
	super initialize.
	
]

{ #category : #accessing }
TKTArchetypedTask >> schedule: executor [
	executor scheduleArchetypedTask: self
]

{ #category : #accessing }
TKTArchetypedTask >> scheduleTaskExecutionFor: aRunner [
	^ self
		configureTaskExecution: TKTRemoteTaskExecution new
		with: aRunner
]

{ #category : #accessing }
TKTArchetypedTask >> serializerSelector [
	^ serializerSelector
]

{ #category : #accessing }
TKTArchetypedTask >> useFuel [
	serializerSelector := #fuel
]

{ #category : #accessing }
TKTArchetypedTask >> useSton [
	serializerSelector := #ston
]

{ #category : #accessing }
TKTArchetypedTask >> useXStoned [
	serializerSelector := #xstoned
]
