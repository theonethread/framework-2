﻿/** * Copyright 2011 by Barnabás Bucsy * * This file is part of The Memento Framework. * * The Memento Framework is free software: you can redistribute it * and/or modify it under the terms of the GNU Lesser General Public * License as published by the Free Software Foundation, either * version 3 of the License, or (at your option) any later version. * * The Memento Framework is distributed in the hope that it will be * useful, but WITHOUT ANY WARRANTY; without even the implied warranty * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU * Lesser General Public License for more details. * * You should have received a copy of the GNU Lesser General Public * License along with The Memento Framework. If not, see * <http://www.gnu.org/licenses/>. */package com.memento.core.color{	import com.memento.core.color.HSV;	import com.memento.core.color.RGB;	import com.memento.utils.NumberUtil;	/**	 * Class for working with Color values given as decimal,	 * hexadecimal, RGB or HSV.	 * @author Barnabás Bucsy (Lobo)	 */	public final class Color	{		/**		 * Decimal representation of the Color.		 */		private var _color:uint;		/**		 * Constructor		 * @param color_ uint The desimal representation of the Color.		 */		public function Color( color_:uint = 0 ):void		{			_color = color_;		}		//------------------		// STATIC INTERFACE		//------------------		/**		 * Creates Color from RGB.		 * @param rgb_ RGB RGB to use.		 * @return Color Created Color.		 */		public static function fromRGB( rgb_:RGB ):Color		{			return new Color( RGBToDEC( rgb_ ) );		}		/**		 * Creates Color from HSV.		 * @param hsv_ HSV HSV to use.		 * @return Color Created Color.		 */		public static function fromHSV( hsv_:HSV ):Color		{			return new Color( RGBToDEC( HSVToRGB( hsv_ ) ) );		}		/**		 * Creates Color from hexadecimal String.		 * @param hex_ String String to parse for hexadecimal Color.		 * @return Color Created Color.		 */		public static function fromHEX( hex_:String ):Color		{			hex_.replace( '#', '0x' );			if ( !hex_.match( '0x' ) )			{				hex_ = '0x' + hex_;			}			return new Color( parseInt( hex_ ) );		}		/**		 * Creates RGB from decimal Color.		 * @param dec_ uint Decimal representation of Color.		 * @return RGB Created RGB.		 */		public static function DECToRGB( dec_:uint ):RGB		{			return new RGB(				dec_ >> 16 & 0xFF,				dec_ >> 8  & 0xFF,				dec_       & 0xFF			);		}		/**		 * Creates HSV from decimal Color.		 * @param dec_ uint Decimal representation of Color.		 * @return HSV Created HSV.		 */		public static function DECToHSV( dec_:uint ):HSV		{			return RGBToHSV( DECToRGB( dec_ ) );		}		/**		 * Creates hexadecimal String from decimal Color.		 * @param dec_ uint Decimal representation of Color.		 * @return String Color represented as hexadecimal String.		 */		public static function DECToHEX( dec_:uint ):String		{			return new Color( dec_ ).toHEXString( );		}		/**		 * Creates decimal Color from RGB.		 * @param rgb_ RGB RGB to use.		 * @return uint Decimal representation of Color.		 */		public static function RGBToDEC( rgb_:RGB ):uint		{			return ( rgb_.red << 16 | rgb_.green << 8 | rgb_.blue );		}		/**		 * Creates HSV from RGB.		 * @param rgb_ RGB RGB to use.		 * @return HSV Created HSV.		 */		public static function RGBToHSV( rgb_:RGB ):HSV		{			var max:uint = Math.max( rgb_.red, rgb_.green, rgb_.blue );			var min:uint = Math.min( rgb_.red, rgb_.green, rgb_.blue );			var hsv:HSV = new HSV( );			if ( max == min )			{				hsv.hue = 0;			}			else if ( max == rgb_.red )			{				hsv.hue = Math.round( ( 60 * ( rgb_.green - rgb_.blue ) / ( max - min ) + 360 ) % 360 );			}			else if( max == rgb_.green )			{				hsv.hue = Math.round( 60 * ( rgb_.blue - rgb_.red ) / ( max - min ) + 120 );			}			else if( max == rgb_.blue )			{				hsv.hue = Math.round( 60 * ( rgb_.red - rgb_.green ) / ( max - min ) + 240 );			}			if ( max == 0 )			{				hsv.saturation = 0;			}			else			{				hsv.saturation = Math.round( ( max - min ) / max *100 );			}			hsv.value = Math.round( max /255 *100 );			return hsv;		}		/**		 * Creates hexadecimal String from RGB.		 * @param rgb_ RGB RGB to use.		 * @return String Color represented as hexadecimal String.		 */		public static function RGBToHEX( rgb_:RGB ):String		{			return Color.fromRGB( rgb_ ).toHEXString( );		}		/**		 * Creates RGB from HSV.		 * @param hsv_ HSV HSV to use.		 * @return RGB Created RGB.		 */		public static function HSVToRGB( hsv_:HSV ):RGB		{			var rgb:RGB = new RGB( );			var tempS:Number = hsv_.saturation *0.01;			var tempV:Number = hsv_.value      *0.01;			var hi:int = Math.floor( hsv_.hue / 60 ) % 6;			var f:Number = hsv_.hue / 60 - Math.floor( hsv_.hue /60 );			var p:Number = ( tempV * ( 1 - tempS ) );			var q:Number = ( tempV * ( 1 - f * tempS ) );			var t:Number = ( tempV * ( 1 - ( 1 - f ) * tempS ) );			switch ( hi )			{				case 0:					rgb.red   = Math.round( tempV *255 );					rgb.green = Math.round( t     *255 );					rgb.blue  = Math.round( p     *255 );					break;				case 1:					rgb.red   = Math.round( q     *255 );					rgb.green = Math.round( tempV *255 );					rgb.blue  = Math.round( p     *255 );					break;				case 2:					rgb.red   = Math.round( p     *255 );					rgb.green = Math.round( tempV *255 );					rgb.blue  = Math.round( t     *255 );					break;				case 3:					rgb.red   = Math.round( p     *255 );					rgb.green = Math.round( q     *255 );					rgb.blue  = Math.round( tempV *255 );					break;				case 4:					rgb.red   = Math.round( t     *255 );					rgb.green = Math.round( p     *255 );					rgb.blue  = Math.round( tempV *255 );					break;				case 5:					rgb.red   = Math.round( tempV *255 );					rgb.green = Math.round( p     *255 );					rgb.blue  = Math.round( q     *255 );					break;			}			return rgb;		}		/**		 * Creates decimal Color from HSV.		 * @param hsv_ HSV HSV to use.		 * @return uint Decimal representation of Color.		 */		public static function HSVToDEC( hsv_:HSV ):uint		{			return RGBToDEC( HSVToRGB( hsv_ ) );		}		/**		 * Creates hexadecimal Color from HSV.		 * @param hsv_ HSV HSV to use.		 * @return String Hexadecimal representation of Color.		 */		public static function HSVToHEX( hsv_:HSV ):String		{			return Color.fromHSV( hsv_ ).toHEXString( );		}		//------------------		// PUBLIC INTERFACE		//------------------		/**		 * Converts the Color to decimal Color representation.		 * @return uint Decimal representation of Color.		 */		public function toDEC( ):uint		{			return _color;		}		/**		 * Converts the Color to RGB.		 * @return RGB Created RGB.		 */		public function toRGB( ):RGB		{			return DECToRGB( _color );		}		/**		 * Converts the Color to RGB String.		 * @return String Created RGB String.		 */		public function toRGBString( ):String		{			var rgb:RGB = DECToRGB( _color );			return 'rgb( ' +				rgb.red.toString( )   + ', ' +				rgb.green.toString( ) + ', ' +				rgb.blue.toString( )  + ' )';		}		/**		 * Converts the Color to HSV.		 * @return HSV Created HSV.		 */		public function toHSV( ):HSV		{			return RGBToHSV( DECToRGB( _color ) );		}		/**		 * Converts the Color to HSV String.		 * @return String Created HSV String.		 */		public function toHSVString( ):String		{			var hsv:HSV = RGBToHSV( DECToRGB( _color ) );			return 'hsv( ' +				hsv.hue.toString( )        + ', ' +				hsv.saturation.toString( ) + ', ' +				hsv.value.toString( )      + ' )';		}		/**		 * Converts the Color to hexadecimal Color representation.		 * @return String Hexadecimal representation of Color.		 */		public function toHEXString( ):String		{			var rgb:RGB = DECToRGB( _color );			return '#' +				NumberUtil.toFixedPlaces( rgb.red,   2, true ) +				NumberUtil.toFixedPlaces( rgb.green, 2, true ) +				NumberUtil.toFixedPlaces( rgb.blue,  2, true );		}	}}