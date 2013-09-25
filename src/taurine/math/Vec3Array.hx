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
abstract Vec3Array(SingleVector)
{
	/**
		Creates a new Vec3Array with the given size.
	**/
	@:extern public inline function new(len:Int)
	{
		this = SingleVector.alloc(len << 2);
	}

	/**
		The number of Vec3 elements contained in this array
	**/
	public var length(get,never):Int;

	@:extern private inline function get_length():Int
	{
		return this.length >>> 2;
	}

	@:extern private inline function t():Vec3Array return untyped this; //get `this` as the abstract type

	/**
		Reinterpret `this` array as its first `Vec3`
	**/
	@:extern inline public function first():Vec3
	{
		return untyped this;
	}

	@:extern public inline function getData():SingleVector
	{
		return this;
	}

	/**
		Creates a copy of the current Vec3Array and returns it
	**/
	public function copy():Vec3Array
	{
		var len = this.length;
		var ret = new Vec3Array(len >>> 2);
		SingleVector.blit(this, 0, ret.getData(), 0, len);
		return ret;
	}

	/**
		Copies Vec3 at `index` to `out`, at `outIndex`
			Returns `out` object
	**/
	public function copyTo(index:Int, out:Vec3Array, outIndex:Int)
	{
		index <<= 2; outIndex <<= 2;
		out[outIndex] = this[index];
		out[outIndex+1] = this[index+1];
		out[outIndex+2] = this[index+2];
		return out;
	}

	/**
		Sets the components of `this` Vec3 at `index`
			Returns itself
	**/
	public function setAt(index:Int, x:Single, y:Single, z:Single):Vec3Array
	{
		index <<= 2;
		this[index] = x;
		this[index+1] = y;
		this[index+2] = z;
		return t();
	}

	/**
		Adds `this` Vec3 at `index` to `b` at `bIndex`, and stores the result at `out` (at `outIndex`)

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function add(index:Int, b:Vec3Array, bIndex:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2;
		bIndex <<= 2;
		outIndex <<= 2;

		out[outIndex] = this[index] + b[bIndex];
		out[outIndex+1] = this[index+1] + b[bIndex+1];
		out[outIndex+2] = this[index+2] + b[bIndex+2];
		return out;
	}

	/**
		Subtracts `this` Vec3 at `index` to `b` at `bIndex`, and stores the result at `out` (at `outIndex`)

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function sub(index:Int, b:Vec3Array, bIndex:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2;
		bIndex <<= 2;
		outIndex <<= 2;

		out[outIndex] = this[index] - b[bIndex];
		out[outIndex+1] = this[index+1] - b[bIndex+1];
		out[outIndex+2] = this[index+2] - b[bIndex+2];
		return out;
	}

	/**
		Multiplies `this` Vec3 at `index` to `b` at `bIndex`, and stores the result at `out` (at `outIndex`)

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function mul(index:Int, b:Vec3Array, bIndex:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2;
		bIndex <<= 2;
		outIndex <<= 2;

		out[outIndex] = this[index] * b[bIndex];
		out[outIndex+1] = this[index+1] * b[bIndex+1];
		out[outIndex+2] = this[index+2] * b[bIndex+2];
		return out;
	}

	/**
		Divides `this` Vec3 at `index` to `b` at `bIndex`, and stores the result at `out` (at `outIndex`)

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function div(index:Int, b:Vec3Array, bIndex:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2;
		bIndex <<= 2;
		outIndex <<= 2;

		out[outIndex] = this[index] / b[bIndex];
		out[outIndex+1] = this[index+1] / b[bIndex+1];
		out[outIndex+2] = this[index+2] / b[bIndex+2];
		return out;
	}

	/**
		Returns the maximum of two vec4's

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function maxFrom(index:Int, b:Vec3Array, bIndex:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2;
		bIndex <<= 2;
		outIndex <<= 2;

		var t0 = this[index], t1 = this[index+1], t2 = this[index+2];
		var b0 = b[bIndex], b1 = b[bIndex+1], b2 = b[bIndex+2];
		out[outIndex] = t0 > b0 ? t0 : b0;
		out[outIndex+1] = t1 > b1 ? t1 : b1;
		out[outIndex+2] = t2 > b2 ? t2 : b2;
		return out;
	}

	/**
		Returns the minimum of two vec4's

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function minFrom(index:Int, b:Vec3Array, bIndex:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2;
		bIndex <<= 2;
		outIndex <<= 2;

		var t0 = this[index], t1 = this[index+1], t2 = this[index+2];
		var b0 = b[bIndex], b1 = b[bIndex+1], b2 = b[bIndex+2];
		out[outIndex] = t0 < b0 ? t0 : b0;
		out[outIndex+1] = t1 < b1 ? t1 : b1;
		out[outIndex+2] = t2 < b2 ? t2 : b2;
		return out;
	}

	/**
		Calculates the maximum of all elements in `this` Vec3Array,
		starting from `startIndex` until `endIndex` (`endIndex` included),
		and stores the result on `out` (at `outIndex`)

			If `endIndex` is less than 0, it will be implicit to be len - endIndex_value;
			If `endIndex` is greater than length, it will be length - 1
			Returns the changed `Vec3Array`
	**/
	public function max(startIndex:Int=0, endIndex:Int=-1, out:Vec3Array, outIndex:Int):Vec3Array
	{
		var mx, my, mz;
		mx = my = mz = FastMath.NEGATIVE_INFINITY;

		var len = this.length >>> 2 - 1;
		if (len < 0) return null;

		if (endIndex < 0)
			endIndex = len + endIndex + 1;
		if (endIndex > len)
			endIndex = len;

		for (i in startIndex...endIndex)
		{
			var i = i << 2;
			var tmp = this[ i ];
			if (mx < tmp) mx = tmp;
			tmp = this[ i + 1 ];
			if (my < tmp) my = tmp;
			tmp = this[ i + 2 ];
			if (mz < tmp) mz = tmp;
		}

		out[outIndex+0] = mx;
		out[outIndex+1] = my;
		out[outIndex+2] = mz;
		return out;
	}

	/**
		Calculates the minimum of all elements in `this` Vec3Array,
		starting from `startIndex` until `endIndex` (`endIndex` included),
		and stores the result on `out` (at `outIndex`)

			If `endIndex` is less than 0, it will be implicit to be len - endIndex_value;
			If `endIndex` is greater than length, it will be length - 1
			Returns the changed `Vec3Array`
	**/
	public function min(startIndex:Int=0, endIndex:Int=-1, out:Vec3Array, outIndex:Int):Vec3Array
	{
		var mx, my, mz, mw;
		mx = my = mz = mw = FastMath.NEGATIVE_INFINITY;

		var len = this.length >>> 2 - 1;
		if (len < 0) return null;

		if (endIndex < 0)
			endIndex = len + endIndex + 1;
		if (endIndex > len)
			endIndex = len;
		for (i in startIndex...endIndex)
		{
			var tmp = this[ (i << 2) + 0 ];
			if (mx > tmp) mx = tmp;
			tmp = this[ (i << 2) + 1 ];
			if (my > tmp) my = tmp;
			tmp = this[ (i << 2) + 2 ];
			if (mz > tmp) mz = tmp;
			tmp = this[ (i << 2) + 3 ];
			if (mw > tmp) mw = tmp;
		}

		out[outIndex+0] = mx;
		out[outIndex+1] = my;
		out[outIndex+2] = mz;
		return out;
	}

	/**
		Scales a Vec3 by a scalar number

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function scale(index:Int, scalar:Single, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2;
		outIndex <<= 2;

		out[outIndex] = this[index] * scalar;
		out[outIndex+1] = this[index+1] * scalar;
		out[outIndex+2] = this[index+2] * scalar;
		return out;
	}

	/**
		Calculates the euclidian distance between two Vec3's
	**/
	public function dist(index:Int, b:Vec3Array, bIndex:Int):Float
	{
		index <<= 2; bIndex <<= 2;
		var a0 = this[index], a1 = this[index+1], a2 = this[index+2];
		var b0 = b[bIndex], b1 = b[bIndex+1], b2 = b[bIndex+2];
		a0 -= b0; a1 -= b1; a2 -= b2;
		return FastMath.sqrt(a0*a0 + a1*a1 + a2*a2);
	}

	/**
		Calculates the squared euclidian distance between two Vec3's
	**/
	public function sqrdist(index:Int, b:Vec3Array, bIndex:Int):Float
	{
		index <<= 2; bIndex <<= 2;
		var a0 = this[index], a1 = this[index+1], a2 = this[index+2];
		var b0 = b[bIndex], b1 = b[bIndex+1], b2 = b[bIndex+2];
		a0 -= b0; a1 -= b1; a2 -= b2;
		return (a0*a0 + a1*a1 + a2*a2);
	}

	/**
		Calculates the length of a `Vec3` at `index`
	**/
	public function lengthAt(index:Int):Float
	{
		index <<= 2;
		var x = this[index], y = this[index+1], z = this[index+2];
		return FastMath.sqrt(x*x + y*y + z*z);
	}

	/**
		Calculates the squared length of a `Vec3` at `index`
	**/
	public function sqrlenAt(index:Int):Float
	{
		index <<= 2;
		var x = this[index], y = this[index+1], z = this[index+2];
		return (x*x + y*y + z*z);
	}

	/**
		Negates the components of a Vec3 at `index`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function neg(index:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2; outIndex <<= 2;
		var x = this[index], y = this[index+1], z = this[index+2];
		out[outIndex] = -x;
		out[outIndex+1] = -y;
		out[outIndex+2] = -z;
		return out;
	}

	/**
		Normalize a Vec3Array at `index`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function normalize(index:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2; outIndex <<= 2;
		normalize_inline(index,out,outIndex);

		return out;
	}

	@:extern inline private function normalize_inline(index:Int, out:Vec3Array, outIndex:Int):Void
	{
		var x = this[index], y = this[index+1], z = this[index+2];
		var len = x*x + y*y + z*z;
		if (len > 0)
		{
			len = FastMath.invsqrt(len);
			out[outIndex] = x * len;
			out[outIndex+1] = y * len;
			out[outIndex+2] = z * len;
		}
	}

	/**
		Calculates the dot product of two Vec3's
	**/
	public function dot(index:Int, b:Vec3Array, bIndex:Int):Float
	{
		index <<= 2; bIndex <<= 2;
		var x = this[index], y = this[index+1], z = this[index+2];
		return b[bIndex] * x + b[bIndex+1] * y + b[bIndex+2] * z;
	}

	/**
		Performs a linear interpolation between two Vec3's

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function lerp(index:Int, to:Vec3Array, toIndex:Int, t:Float, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2; outIndex <<= 2; toIndex <<= 2;
		var x = this[index], y = this[index+1], z = this[index+2];
		var bx = to[toIndex], by = to[toIndex+1], bz = to[toIndex+2];

		out[outIndex] = x + t * (bx - x);
		out[outIndex+1] = y + t * (by - y);
		out[outIndex+2] = z + t * (bz - z);
		return out;
	}

	/**
		Transforms the `Vec3` with a `Mat4`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function transformMat4(index:Int, m:Mat4Array, mIndex:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2; outIndex <<= 2; mIndex <<= 4;
		var x = this[index], y = this[index+1], z = this[index+2];
		var m0 = m[mIndex], m1 = m[mIndex+1], m2 = m[mIndex + 2], m3 = m[mIndex + 3],
				m4 = m[mIndex + 4], m5 = m[mIndex + 5], m6 = m[mIndex + 6], m7 = m[mIndex + 7],
				m8 = m[mIndex + 8], m9 = m[mIndex + 9], m10 = m[mIndex + 10], m11 = m[mIndex + 11],
				m12 = m[mIndex + 12], m13 = m[mIndex + 13], m14 = m[mIndex + 14], m15 = m[mIndex + 15];
    out[outIndex+0] = m0 * x + m4 * y + m8 * z + m12;
    out[outIndex+1] = m1 * x + m5 * y + m9 * z + m13;
    out[outIndex+2] = m2 * x + m6 * y + m10 * z + m14;

		return out;
	}

	/**
		Transforms the `Vec3` with a `Quat`

			If `out` is null, it will implicitly be considered itself;
			If `outIndex` is null, it will be considered to be the same as `index`.
			Returns the changed `Vec3Array`
	**/
	public function transformQuat(index:Int, q:QuatArray, qIndex:Int, ?out:Vec3Array, ?outIndex:Int):Vec3Array
	{
		if (out == null)
		{
			out = t();
			if (outIndex == null)
				outIndex = index;
		}
		index <<= 2; outIndex <<= 2; qIndex <<= 2;
		var x = this[index], y = this[index+1], z = this[index+2];
		var qx = q[qIndex], qy = q[qIndex+1], qz = q[qIndex+2], qw = q[qIndex+3];
        // calculate quat * vec
    var ix = qw * x + qy * z - qz * y,
        iy = qw * y + qz * x - qx * z,
        iz = qw * z + qx * y - qy * x,
        iw = -qx * x - qy * y - qz * z;

    // calculate result * inverse quat
    out[outIndex+0] = ix * qw + iw * -qx + iy * -qz - iz * -qy;
    out[outIndex+1] = iy * qw + iw * -qy + iz * -qx - ix * -qz;
    out[outIndex+2] = iz * qw + iw * -qz + ix * -qy - iy * -qx;
		return out;
	}


	@:extern inline public function forEach(fn:Vec3Array->Int->Void):Void
	{
		var len = this.length >>> 2;
		for (i in 0...len)
		{
			fn(t(),i);
		}
	}

	public function toString():String
	{
		var buf = new StringBuf();
		var len = this.length >>> 2;
		if (len << 2 > this.length) len--; //be safe
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
				buf.add(this[ (i << 2) + j ]);
			}
			buf.add("), ");
		}
		buf.add("\n}");

		return buf.toString();
	}

}