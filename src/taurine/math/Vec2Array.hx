/* Copyright (c) 2013, Brandon Jones, Colin MacKenziewIV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
package taurine.math;

//This library was ported from the JavaScript library `glMatrix` - copyright above
import haxe.ds.Vector;
import taurine.Single;

/**
	3 Dimensional Vector Array
**/
abstract Vec2Array(SingleVector)
{
	/**
		Creates a new Vec2Array with the given size.
	**/
	@:extern public inline function new(len:Int)
	{
		this = SingleVector.alloc(len << 1);
	}

	/**
		The number of Vec2 elements contained in this array
	**/
	public var length(get,never):Int;

	@:extern private inline function get_length():Int
	{
		return this.length >>> 1;
	}

	@:extern private inline function t():Vec2Array return untyped this; //get `this` as the abstract type

	/**
		Reinterpret `this` array as its first `Vec2`
	**/
	@:extern inline public function first():Vec2
	{
		return untyped this;
	}

	@:extern public inline function getData():SingleVector
	{
		return this;
	}

	/**
		Creates a copy of the current Vec2Array and returns it
	**/
	public function copy():Vec2Array
	{
		var len = this.length;
		var ret = new Vec2Array(len >>> 1);
		SingleVector.blit(this, 0, ret.getData(), 0, len);
		return ret;
	}

	/**
		Copies Vec2 at `index` to `out`, at `outIndex`
			Returns `out` object
	**/
	public function copyTo(index:Int, out:Vec2Array, outIndex:Int)
	{
		index <<= 1; var outIndex:Int = outIndex << 1;
		out[outIndex] = this[index];
		out[outIndex+1] = this[index+1];
		return out;
	}

	/**
		Sets the components of `this` Vec2 at `index`
			Returns itself
	**/
	public function setAt(index:Int, x:Single, y:Single, z:Single):Vec2Array
	{
		index <<= 1;
		this[index] = x;
		this[index+1] = y;
		return t();
	}

	/**
		Adds `this` Vec2 at `index` to `b` at `bIndex`, and stores the result at `out` (at `outIndex`)

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function add(index:Int, b:Vec2Array, bIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1;
		bIndex <<= 1;
		var outIndex:Int = outIndex << 1;

		out[outIndex] = this[index] + b[bIndex];
		out[outIndex+1] = this[index+1] + b[bIndex+1];
		return out;
	}

	/**
		Subtracts `this` Vec2 at `index` to `b` at `bIndex`, and stores the result at `out` (at `outIndex`)

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function sub(index:Int, b:Vec2Array, bIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1;
		bIndex <<= 1;
		var outIndex:Int = outIndex << 1;

		out[outIndex] = this[index] - b[bIndex];
		out[outIndex+1] = this[index+1] - b[bIndex+1];
		return out;
	}

	/**
		Multiplies `this` Vec2 at `index` to `b` at `bIndex`, and stores the result at `out` (at `outIndex`)

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function mul(index:Int, b:Vec2Array, bIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1;
		bIndex <<= 1;
		var outIndex:Int = outIndex << 1;

		out[outIndex] = this[index] * b[bIndex];
		out[outIndex+1] = this[index+1] * b[bIndex+1];
		return out;
	}

	/**
		Divides `this` Vec2 at `index` to `b` at `bIndex`, and stores the result at `out` (at `outIndex`)

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function div(index:Int, b:Vec2Array, bIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1;
		bIndex <<= 1;
		var outIndex:Int = outIndex << 1;

		out[outIndex] = this[index] / b[bIndex];
		out[outIndex+1] = this[index+1] / b[bIndex+1];
		return out;
	}

	/**
		Returns the maximum of two vec4's

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function maxFrom(index:Int, b:Vec2Array, bIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1;
		bIndex <<= 1;
		var outIndex:Int = outIndex << 1;

		var t0 = this[index], t1 = this[index+1];
		var b0 = b[bIndex], b1 = b[bIndex+1];
		out[outIndex] = t0 > b0 ? t0 : b0;
		out[outIndex+1] = t1 > b1 ? t1 : b1;
		return out;
	}

	/**
		Returns the minimum of two vec4's

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function minFrom(index:Int, b:Vec2Array, bIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1;
		bIndex <<= 1;
		var outIndex:Int = outIndex << 1;

		var t0 = this[index], t1 = this[index+1];
		var b0 = b[bIndex], b1 = b[bIndex+1];
		out[outIndex] = t0 < b0 ? t0 : b0;
		out[outIndex+1] = t1 < b1 ? t1 : b1;
		return out;
	}

	/**
		Calculates the maximum of all elements in `this` Vec2Array,
		starting from `startIndex` until `endIndex` (`endIndex` included),
		and stores the result on `out` (at `outIndex`)

			If `endIndex` is less than 0, it will be implicit to be len - endIndex_value;
			If `endIndex` is greater than length, it will be length - 1
			Returns the changed `Vec2Array`
	**/
	public function max(startIndex:Int=0, endIndex:Int=-1, out:Vec2Array, outIndex:Int):Vec2Array
	{
		var mx, my;
		mx = my = FastMath.NEGATIVE_INFINITY;

		var len = this.length >>> 1 - 1;
		if (len < 0) return null;

		if (endIndex < 0)
			endIndex = len + endIndex + 1;
		if (endIndex > len)
			endIndex = len;

		for (i in startIndex...endIndex)
		{
			var i = i << 1;
			var tmp = this[ i ];
			if (mx < tmp) mx = tmp;
			tmp = this[ i + 1 ];
			if (my < tmp) my = tmp;
		}

		out[outIndex+0] = mx;
		out[outIndex+1] = my;
		return out;
	}

	/**
		Calculates the minimum of all elements in `this` Vec2Array,
		starting from `startIndex` until `endIndex` (`endIndex` included),
		and stores the result on `out` (at `outIndex`)

			If `endIndex` is less than 0, it will be implicit to be len - endIndex_value;
			If `endIndex` is greater than length, it will be length - 1
			Returns the changed `Vec2Array`
	**/
	public function min(startIndex:Int=0, endIndex:Int=-1, out:Vec2Array, outIndex:Int):Vec2Array
	{
		var mx, my;
		mx = my = FastMath.NEGATIVE_INFINITY;

		var len = this.length >>> 1 - 1;
		if (len < 0) return null;

		if (endIndex < 0)
			endIndex = len + endIndex + 1;
		if (endIndex > len)
			endIndex = len;
		for (i in startIndex...endIndex)
		{
			var tmp = this[ (i << 1) + 0 ];
			if (mx > tmp) mx = tmp;
			tmp = this[ (i << 1) + 1 ];
			if (my > tmp) my = tmp;
		}

		out[outIndex+0] = mx;
		out[outIndex+1] = my;
		return out;
	}

	/**
		Scales a Vec2 by a scalar number

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function scale(index:Int, scalar:Single, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1;
		var outIndex:Int = outIndex << 1;

		out[outIndex] = this[index] * scalar;
		out[outIndex+1] = this[index+1] * scalar;
		return out;
	}

	/**
		Calculates the euclidian distance between two Vec2's
	**/
	public function dist(index:Int, b:Vec2Array, bIndex:Int):Float
	{
		index <<= 1; bIndex <<= 1;
		var a0 = this[index], a1 = this[index+1];
		var b0 = b[bIndex], b1 = b[bIndex+1];
		a0 -= b0; a1 -= b1; a2 -= b2;
		return FastMath.sqrt(a0*a0 + a1*a1 + a2*a2);
	}

	/**
		Calculates the squared euclidian distance between two Vec2's
	**/
	public function sqrdist(index:Int, b:Vec2Array, bIndex:Int):Float
	{
		index <<= 1; bIndex <<= 1;
		var a0 = this[index], a1 = this[index+1];
		var b0 = b[bIndex], b1 = b[bIndex+1];
		a0 -= b0; a1 -= b1; a2 -= b2;
		return (a0*a0 + a1*a1 + a2*a2);
	}

	/**
		Calculates the length of a `Vec2` at `index`
	**/
	public function lengthAt(index:Int):Float
	{
		index <<= 1;
		var x = this[index], y = this[index+1];
		return FastMath.sqrt(x*x + y*y);
	}

	/**
		Calculates the squared length of a `Vec2` at `index`
	**/
	public function sqrlenAt(index:Int):Float
	{
		index <<= 1;
		var x = this[index], y = this[index+1];
		return (x*x + y*y);
	}

	/**
		Negates the components of a Vec2 at `index`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function neg(index:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1; var outIndex:Int = outIndex << 1;
		var x = this[index], y = this[index+1];
		out[outIndex] = -x;
		out[outIndex+1] = -y;
		return out;
	}

	/**
		Normalize a Vec2Array at `index`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function normalize(index:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1; var outIndex:Int = outIndex << 1;
		normalize_inline(index,out,outIndex);

		return out;
	}

	@:extern inline private function normalize_inline(index:Int, out:Vec2Array, outIndex:Int):Void
	{
		var x = this[index], y = this[index+1];
		var len = x*x + y*y;
		if (len > 0)
		{
			len = FastMath.invsqrt(len);
			out[outIndex] = x * len;
			out[outIndex+1] = y * len;
		}
	}

	/**
		Calculates the dot product of two Vec2's
	**/
	public function dot(index:Int, b:Vec2Array, bIndex:Int):Float
	{
		index <<= 1; bIndex <<= 1;
		var x = this[index], y = this[index+1];
		return b[bIndex] * x + b[bIndex+1] * y;
	}

	/**
		Performs a linear interpolation between two Vec2's

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function lerp(index:Int, to:Vec2Array, toIndex:Int, t:Float, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1; var outIndex:Int = outIndex << 1; toIndex <<= 1;
		var x = this[index], y = this[index+1];
		var bx = to[toIndex], by = to[toIndex+1];

		out[outIndex] = x + t * (bx - x);
		out[outIndex+1] = y + t * (by - y);
		return out;
	}

	/**
		Transforms the `Vec2` with a `Mat2`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function transformMat2(index:Int, m:Mat2Array, mIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1; var outIndex:Int = outIndex << 1; mIndex <<= 2;

		var x = this[index+0], y = this[index+1];
		out[outIndex+0] = m[mIndex+0] * x + m[mIndex+2] * y;
    out[outIndex+1] = m[mIndex+1] * x + m[mIndex+3] * y;
		return out;
	}

	/**
		Transforms the `Vec2` with a `Mat2D`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function transformMat2D(index:Int, m:Mat2DArray, mIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1; var outIndex:Int = outIndex << 1; mIndex <<= 3;

		var x = this[index+0], y = this[index+1];
		out[outIndex+0] = m[mIndex+0] * x + m[mIndex+2] * y + m[mIndex+4];
    out[outIndex+1] = m[mIndex+1] * x + m[mIndex+3] * y + m[mIndex+4];
		return out;
	}

	/**
		Transforms the `Vec2` with a `Mat3`
		3rd vector component is implicitly `1`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function transformMat3(index:Int, m:Mat3Array, mIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1; var outIndex:Int = outIndex << 1; mIndex <<= 4;
		var x = this[index], y = this[index+1];
		var m0 = m[mIndex], m1 = m[mIndex+1],  m3 = m[mIndex + 3],
				m4 = m[mIndex + 4],  m6 = m[mIndex + 6], m7 = m[mIndex + 7];
    out[outIndex+0] = m0 * x + m3 * y + m6;
    out[outIndex+1] = m1 * x + m4 * y + m7;

		return out;
	}

	/**
		Transforms the `Vec2` with a `Mat4`
		3rd and 4th vector components are implicitly `1`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec2Array`
	**/
	public function transformMat4(index:Int, m:Mat4Array, mIndex:Int, ?out:Vec2Array, ?outIndex:Int):Vec2Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 1; var outIndex:Int = outIndex << 1; mIndex <<= 4;
		var x = this[index], y = this[index+1], z = this[index+2];
		var m0 = m[mIndex], m1 = m[mIndex+1],
				m4 = m[mIndex + 4], m5 = m[mIndex + 5],
				m12 = m[mIndex + 12], m13 = m[mIndex + 13];
    out[outIndex+0] = m0 * x + m4 * y + m8 * z + m12;
    out[outIndex+1] = m1 * x + m5 * y + m9 * z + m13;

		return out;
	}

	@:extern inline public function forEach(fn:Vec2Array->Int->Void):Void
	{
		var len = this.length >>> 1;
		for (i in 0...len)
		{
			fn(t(),i);
		}
	}

	public function toString():String
	{
		var buf = new StringBuf();
		var len = this.length >>> 1;
		if (len << 1 > this.length) len--; //be safe
		buf.add('vec3[');
		buf.add(len);
		buf.add(']\n{');
		for (i in 0...len)
		{
			buf.add('\n\t');
			buf.add('vec3(');
			var fst = true;
			for (j in 0...3)
			{
				if (fst) fst = false; else buf.add(", ");
				buf.add(this[ (i << 1) + j ]);
			}
			buf.add("), ");
		}
		buf.add("\n}");

		return buf.toString();
	}

}
