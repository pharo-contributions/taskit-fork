Class {
	#name : #BaselineOfForkIt,
	#superclass : #BaselineOf,
	#instVars : [
		'repository'
	],
	#category : #BaselineOfForkIt
}

{ #category : #baselines }
BaselineOfForkIt >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'ParametrizedTests'
					with: [ spec repository: 'github://tesonep/ParametrizedTests' ];
				baseline: 'Equals'
					with: [ spec repository: 'github://bouraqadi/PharoMisc' ];
				baseline: #TaskItArchetype
					with: [ spec repository: 'github://pharo-contributions/taskit-archetype' ];
				baseline: #TaskIt
					with: [ spec repository: 'github://pharo-contributions/taskit' ];
				package: 'TaskItForkIt-Tests'
					with: [ spec requires: #(TaskItForkIt) ];
				package: #TaskItForkIt
					with: [ spec requires: #(TaskIt TaskItArchetype Equals ParametrizedTests) ].
			spec group: 'minimal' with: #(#TaskItForkIt 'TaskItForkIt-Tests') ]
]
