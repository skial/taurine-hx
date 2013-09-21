package taurine.mem._internal.cs;
import cs.NativeArray;
import cs.StdTypes;

@:final class RawMemData
{
	public var data(default,null):NativeArray<UInt8>;
	private var f:NativeArray<Single>;
	private var d:NativeArray<Float>;

	function new(len:Int)
	{
		this.data = new NativeArray(len);
		this.f = new NativeArray(1);
		this.d = new NativeArray(1);
	}

	@:final public inline function getUInt8(offset:Int):Int
	{
		return cast data[offset];
	}

	@:final public inline function setUInt8(offset:Int, v:Int)
	{
		data[offset] = cast v;
	}

	@:final public function getFloat32(offset:Int):Float
	{
		var f = f;
		Buffer.BlockCopy(data,offset,f, 0, 4);
		return cast f[0];
	}

	@:final public function setFloat32(offset:Int, val:Float):Void
	{
		var f = f;
		f[0] = cast val;
		Buffer.BlockCopy(f, 0, data, offset, 4);
	}

	@:final public function getFloat64(offset:Int):Float
	{
		var d = d;
		Buffer.BlockCopy(data,offset,d,0,8);
		return cast d[0];
	}

	@:final public function setFloat64(offset:Int, val:Float):Void
	{
		var d = d;
		d[0] = cast val;
		Buffer.BlockCopy(d, 0, data, offset, 8);
	}
}

@:native("System.Buffer")
private extern class Buffer
{
	public static function BlockCopy(src:cs.Array, srcOffset:Int, dst:cs.Array, dstOffset:Int, count:Int):Void;
}
