// RGGb - Counting Classes

class RGGs {
	tag = "RGGs";
	class functions_Spawn {
		file = "functions_Spawn";

		class spawn_baseSpawnContainer {
			Description = "This function will create the correct container (or truck) to generate the next base";
		};

		class spawn_baseSpawnContainerLevel2 {
			Description = "This function will create the correct container (or truck) to generate the next base - all level 1 basses must be built and be healthy first";
		};

		class spawn_bluforBaseMinCrew {
			Description = "This function will create minimum base crew of 8 units";
		};

		class spawn_bluforSentries {
			Description = "This function will create wall and tower AI sentries";
		};

		class spawn_opforCamp {
			Description = "This function will generate small enemy camp";
		};

		class spawn_bluforSentryRespawnQueue {
			Description = "This function will temporarily house any sentry data due to a base being unable to respawn a unit";
		};

	};
};