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
				baseline: 'Equals'
					with: [ spec repository: 'github://bouraqadi/PharoMisc' ];
				baseline: #TaskItArchetype
					with: [ spec repository: 'github://pharo-contributions/taskit-archetypes' ];
				baseline: #TaskIt
					with: [ spec repository: 'github://pharo-contributions/taskit' ];
				package: 'TaskItForkIt-Tests'
					with: [ spec requires: #(TaskItForkIt) ];
				package: #TaskItForkIt
					with: [ spec requires: #(TaskIt TaskItArchetype Equals) ].
			spec group: 'minimal' with: #(#TaskItForkIt 'TaskItForkIt-Tests') ]
]
