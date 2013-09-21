package taurine.mem._internal.js;

@:keep class RawMemCompat
{
	static function __init__()
	{
		if (untyped __js__('typeof DataView == "undefined"'))
		{
			alloc = allocCompat;
		}
	}

	public static dynamic function alloc(byteLength:Int):js.html.DataView
	{
		return new js.html.DataView(new js.html.ArrayBuffer(byteLength));
	}

	public static function allocCompat(byteLength:Int):js.html.DataView
	{
		return cast new RawMemCompat(byteLength);
	}

	public var byteLength(default,null):Int;
	private var arr:Array<Int>;
	private var typedArray:Bool;

	public function new(len)
	{
		this.byteLength = len;
		//some browsers do not have DataView but do have TypedArray
		if (untyped __js__('typeof Uint8Array == "undefined"))
		{
			this.array = untyped __new__(Array, len);
			this.typedArray = false;
		} else {
			this.array = cast new js.html.Uint8Array(len);
			this.typedArray = true;
		}
	}

	public inline function getUint8(offset:Int):Int
	{
		return arr[offset] | 0;
	}

	public inline function setUint8(offset:Int, val:Int):Void
	{
		arr[offset] = val & 0xFF;
	}

	public function getUint16(offset:Int):Int
	{
		return getUint8(offset) | (getUint8(offset + 1) << 8);
	}

	public function setUint16(offset:Int, val:Int)
	{
		setUint8(offset, val); setUint8(offset+1, val >> 8);
	}

	public function getInt32(offset:Int):Int
	{
		return getUint8(offset) | (getUint8(offset+1) << 8) | (getUint8(offset+2) << 16) | (getUint8(offset+3) << 24);
	}

	public function setInt32(offset:Int, val:Int):Void
	{
		setUint8(offset, val); setUint8(offset+1, val >> 8); setUint8(offset+2, val >> 16); setUint8(offset+3, val >>> 24);
	}

	public function getFloat32(offset:Int):Float
	{
		var b0 = getUint8(offset), b1 = getUint8(offset+1), b2 = getUint8(offset+2), b3 = getUint8(offset+3);
		var sign = 1 - ((b0 >> 7) << 1);
		var exp = (((b0 << 1) & 0xFF) | (b1 >> 7)) - 127;
		var sig = ((b1 & 0x7F) << 16) | (b2 << 8) | b3;
		if (sig == 0 && exp == -127)
			return 0.0;
		return sign*(1 + Math.pow(2, -23)*sig) * Math.pow(2, exp);
	}

	public function setFloat32(offset:Int, val:Float):Void
	{
		if (val == 0.0)
		{
			for(i in 0...4)
				arr[offset+i] = 0;
			return;
		}
		var exp = Math.floor(Math.log(Math.abs(val)) / LN2);
		var sig = (Math.floor(Math.abs(val) / Math.pow(2, exp) * (2 << 22)) & 0x7FFFFF);
		var b1 = (exp + 0x7F) >> 1 | (exp>0 ? ((val<0) ? 1<<7 : 1<<6) : ((val<0) ? 1<<7 : 0)),
			b2 = (exp + 0x7F) << 7 & 0xFF | (sig >> 16 & 0x7F),
			b3 = (sig >> 8) & 0xFF,
			b4 = sig & 0xFF;
		setUint8(offset, b1); setUint8(offset+1,b2); setUint8(offset+2,b3); setUint8(offset+3,b4);
	}

	public function getFloat64(offset:Int):Float
	{
		var b0 = getUint8(offset), b1 = getUint8(offset+1), b2 = getUint8(offset+2), b3 = getUint8(offset+3);
		var b4 = getUint8(offset+4), b5 = getUint8(offset+5), b6 = getUint8(offset+6), b7 = getUint8(offset+7);

		var sign = 1 - ((b0 >> 7) << 1); // sign = bit 0
		var exp = (((b0 << 4) & 0x7FF) | (b1 >> 4)) - 1023; // exponent = bits 1..11
		var sig = (((b1&0xF) << 16) | (b2 << 8) | b3 ) * 4294967296. +
				(b4 >> 7) * 2147483648 +
				(((b4&0x7F) << 24) | (b5 << 16) | (b6 << 8) | b7);
		if (sig == 0 && exp == -1023)
			return 0.0;
		return sign * (1.0 + Math.pow(2, -52) * sig) * Math.pow(2, exp);
	}

	public function setFloat64(offset:Int, val:Float):Void
	{
		if (val == 0)
		{
			for(i in 0...8)
				arr[offset+i] = 0;
			return;
		}
		var exp = Math.floor(Math.log(Math.abs(val)) / LN2);
		var sig : Int = Math.floor(Math.abs(val) / Math.pow(2, exp) * Math.pow(2, 52));
		var sig_h = (sig & cast 34359738367);
		var sig_l = Math.floor((sig / Math.pow(2,32)));
		var b1 = (exp + 0x3FF) >> 4 | (exp>0 ? ((val<0) ? 1<<7 : 1<<6) : ((val<0) ? 1<<7 : 0)),
			b2 = (exp + 0x3FF) << 4 & 0xFF | (sig_l >> 16 & 0xF),
			b3 = (sig_l >> 8) & 0xFF,
			b4 = sig_l & 0xFF,
			b5 = (sig_h >> 24) & 0xFF,
			b6 = (sig_h >> 16) & 0xFF,
			b7 = (sig_h >> 8) & 0xFF,
			b8 = sig_h & 0xFF;
		setUint8(offset, b1); setUint8(offset+1,b2); setUint8(offset+2,b3); setUint8(offset+3,b4);
		setUint8(offset+4, b5); setUint8(offset+5,b6); setUint8(offset+6,b7); setUint8(offset+7,b8);
	}
}
