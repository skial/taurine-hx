package taurine.tests;
import taurine.tests.io.PathTests;
import taurine.tests.io.GlobTests;
import taurine.tests.io.UriTests;
import utest.Runner;
import utest.ui.Report;

/**
 * ...
 * @author waneck
 */
class Test
{

	static function main()
	{
		var startAnim = true, someBool = false, noGo = false, otherBool = true, someBool = false;
		var g = taurine.async.Generator.test({
if (startAnim)
{
	var x = 10;
	var y = 30;
	if (someBool)
		x = 200;

	if (noGo)
	{
		@yield return 10;
	}
	else
	{
		if (otherBool)
		{
			var z = 10;

			// for (i in 0...1000)
			var i = 100;
			{
				@yield return i + x;
				trace(10);
			}

			if (startAnim)
			{
				var x = 10;
				var y = 30;
				if (someBool)
					x = 200;

				// var x = if (noGo)
				if (noGo)
				{
					@yield return 10;
					trace('hi');
					600;
				}
				else
				{
					if (otherBool)
					{
						var z = 10;

						// for (i in 0...1000)
						var i = 1000;
						{
							@yield return i + x;
							trace(20);
						}

						trace("here");
						@yield return x + y + z;
					}
					trace("ha");
					900;
				}

				var z = 10;
				trace(z + x);
			}

			trace("here");
			@yield return x + y + z;
		}
		trace("ha");
	}

	var z = "zuba";
	trace(z + x);
}
		});
		var runner = new Runner();

		runner.addCase(new PathTests());
		runner.addCase(new GlobTests());
		runner.addCase(new UriTests());
		runner.addCase(new taurine.tests.UInt8Tests());
		runner.addCase(new taurine.tests.mem.RawMemTests());
#if js
		runner.addCase(new taurine.tests.mem.RawMemTests.RawMemTestsBackwards());
		runner.addCase(new taurine.tests.mem.RawMemTests.RawMemTestsArray());
#end
		runner.addCase(new taurine.tests.math.MatrixTests());
		runner.addCase(new taurine.tests.math.QuatTests());

		// var report = Report.create(runner);
		var report = new utest.ui.text.PrintReport(runner);
		runner.run();

#if sys
		//Sys.exit(report.allOk() ? 0 : 1);
#end
	}

	private static function teste(a:Int)
	{
		trace(a);
	}

	@:extern inline private static function teste1(a:Int=-2)
	{
		teste(a);
	}

}
