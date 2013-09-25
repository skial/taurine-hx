/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

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
	4x4 Matrix
**/
@:arrayAccess
abstract Mat2D(SingleVector) to Mat2DArray
{
  public var a(get,set):Single;
  public var b(get,set):Single;
  public var c(get,set):Single;
  public var d(get,set):Single;
  public var tx(get,set):Single;
  public var ty(get,set):Single;

	/**
		Creates a new identity Mat2D
	**/
	@:extern public inline function new()
	{
		this = SingleVector.alloc(6);
		this[0] = this[3] = 1;
	}

  /**
    Creates an empty Mat2D
  **/
  @:extern inline public static function mk():Mat2D
  {
    return untyped SingleVector.alloc(6);
  }

  /**
    Tells whether this Mat2D has more than one Mat2D element
  **/
  @:extern inline public function hasMultiple():Bool
  {
    return this.length > 6;
  }

  /**
    Clones the current Mat2D
  **/
  public function clone():Mat2D
  {
    var ret = mk();
    for (i in 0...6) ret[i] = this[i];
    return ret;
  }

  /**
    Copies `this` matrix to `dest`, and returns `dest`
  **/
  public function copyTo(dest:Mat2D):Mat2D
  {
    for (i in 0...6)
      dest[i] = this[i];
    return dest;
  }

	@:extern private inline function t():Mat2D return untyped this; //get `this` as the abstract type

  /**
    Reinterpret `this` Matrix as an array (of length 1)
  **/
  @:extern inline public function array():Mat2DArray
  {
    return untyped this;
  }

	@:extern public inline function getData():SingleVector
	{
		return this;
	}

	/**
		Set the Mat2D at `index` to the identity matrix.

			Returns itself
	**/
	public function identity():Mat2D
	{
		this[0] = this[3] = 1
		this[1] = this[2] = this[4] =	this[5] = 0;
		return t();
	}

	/**
		Inverts current matrix and stores the value at `out` matrix

			If `out` is null, it will implicitly be considered itself;
			Returns the changed `Mat2D`; If the operation fails, returns `null`
	**/
	@:extern inline public function invert(?out:Mat2D):Mat2D
	{
    return Mat2DArray.invert(t(), 0, out, 0).first();
	}

	/**
		Calculates de determinant of the Mat2D
	**/
	@:extern inline public function determinant():Float
	{
    return Mat2DArray.determinant(t(),0);
	}

	/**
		Multiplies current matrix with matrix `b`,
		and stores the value on `out` matrix

			If `out` is null, it will implicitly be considered itself;
			Returns the changed `Mat2D`
	**/
  @:extern inline public function mul(b:Mat2D, ?out:Mat2D):Mat2D
  {
    return Mat2DArray.mul(t(), 0, b, 0, out, 0);
  }

  @:op(A*B) @:extern inline public static function opMult(a:Mat2D, b:Mat2D):Mat2D
  {
    return Mat2DArray.mul(a,0,b,0,mk(),0);
  }

	/**
		Translates the mat4 with `x`, `y`.

			If `out` is null, it will implicitly be considered itself;
			Returns the changed `Mat2D`
	**/
  @:extern inline public function translate(x:Single, y:Single, ?out:Mat2D):Mat2D
	{
    return Mat2DArray.translate(t(),x,y,out).first();
	}

	/**
		Translates the mat4 with the `vec` Vec3
		@see Mat2D#translate
	**/
	@:extern inline public function translate_v(vec:Vec3, ?out:Mat2D):Mat2D
	{
		return translate(vec[0],vec[1],vec[2],out);
	}

	/**
		Scales the mat4 by `x`, `y`

			If `out` is null, it will implicitly be considered itself;
			Returns the changed `Mat2D`
	**/
	@:extern inline public function scale(x:Single, y:Single, ?out:Mat2D):Mat2D
	{
    return Mat2DArray.scale(t(),0,x,y,out,0).first();
	}

	@:extern inline public function scale_v(vec:Vec3, ?out:Mat2D):Mat2D
	{
		return scale(vec[0],vec[1],vec[2],out);
	}

	/**
		Rotates `this` matrix by the given angle at the (`x`, `y`) vector

			If `out` is null, it will implicitly be considered itself;
			Returns the changed `Mat2D`
	**/
	@:extern inline public function rotate(angle:Rad, x:Single, y:Single, ?out:Mat2D):Mat2D
	{
    return Mat2DArray.rotate(t(),0,angle,x,y,out,0).first();
	}

	@:extern inline public function rotate_v(angle:Rad, vec:Vec3, ?out:Mat2D):Mat2D
	{
		return rotate(angle,vec[0],vec[1],vec[2],out);
	}

	public function toString():String
	{
		var buf = new StringBuf();
		var support = [], maxn = 0;
    buf.add('mat2d(');
    for (i in 0...6)
    {
      var s = support[ i ] = this[ i ] + "";
      if (s.length > maxn) maxn = s.length;
    }

    var fst = true;
    for (j in 0...3)
    {
      if (fst) fst = false; else buf.add('      ');
      for (k in 0...2)
      {
        buf.add(StringTools.rpad(support[ (j * 3) + k ], " ", maxn));
				buf.add(", ");
      }
			buf.add(", ");
			buf.add( j == 2 ? "1" : "0");
    }
    buf.add(")");

		return buf.toString();
	}

	//boilerplate
  @:extern inline private function get_a():Single return this[0];
  @:extern inline private function set_a(val:Single):Single return this[0] = val;
  @:extern inline private function get_b():Single return this[1];
  @:extern inline private function set_b(val:Single):Single return this[1] = val;
  @:extern inline private function get_c():Single return this[2];
  @:extern inline private function set_c(val:Single):Single return this[2] = val;
  @:extern inline private function get_d():Single return this[3];
  @:extern inline private function set_d(val:Single):Single return this[3] = val;
  @:extern inline private function get_tx():Single return this[4];
  @:extern inline private function set_tx(val:Single):Single return this[4] = val;
  @:extern inline private function get_ty():Single return this[5];
  @:extern inline private function set_ty(val:Single):Single return this[5] = val;
}