// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Portal"
{
	Properties
	{
		_UVCenter("UVCenter", Vector) = (0.5,0.5,0,0)
		_TimeScale("TimeScale", Float) = 1
		[HDR]_PortalColor("PortalColor", Color) = (1,0,0,0)
		_PortalRange("PortalRange", Range( 0.3 , 0.5)) = 0
		[HDR]_PortalDetailColor("PortalDetailColor", Color) = (0,0,0,0)
		_CenterPower("CenterPower", Float) = 0
		_CenterRange("CenterRange", Float) = 0
		_CenterColor("CenterColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float4 _PortalColor;
		uniform float _PortalRange;
		uniform float _TimeScale;
		uniform float2 _UVCenter;
		uniform float4 _PortalDetailColor;
		uniform float4 _CenterColor;
		uniform float _CenterRange;
		uniform float _CenterPower;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		float2 voronoihash114( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi114( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash114( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		float2 voronoihash134( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi134( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash134( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 screenColor130 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,ase_grabScreenPosNorm.xy);
			float temp_output_118_0 = distance( i.uv_texcoord , float2( 0.5,0.5 ) );
			float temp_output_121_0 = ( 1.0 - pow( ( temp_output_118_0 / _PortalRange ) , 0.83 ) );
			float time114 = 0.0;
			float mulTime7 = _Time.y * _TimeScale;
			float cos5 = cos( mulTime7 );
			float sin5 = sin( mulTime7 );
			float2 rotator5 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos5 , -sin5 , sin5 , cos5 )) + float2( 0.5,0.5 );
			float2 center45_g3 = _UVCenter;
			float2 delta6_g3 = ( rotator5 - center45_g3 );
			float angle10_g3 = ( length( delta6_g3 ) * 8.681004 );
			float x23_g3 = ( ( cos( angle10_g3 ) * delta6_g3.x ) - ( sin( angle10_g3 ) * delta6_g3.y ) );
			float2 break40_g3 = center45_g3;
			float2 break41_g3 = float2( -0.12,-0.06 );
			float y35_g3 = ( ( sin( angle10_g3 ) * delta6_g3.x ) + ( cos( angle10_g3 ) * delta6_g3.y ) );
			float2 appendResult44_g3 = (float2(( x23_g3 + break40_g3.x + break41_g3.x ) , ( break40_g3.y + break41_g3.y + y35_g3 )));
			float2 temp_output_116_0 = appendResult44_g3;
			float2 coords114 = temp_output_116_0 * 3.0;
			float2 id114 = 0;
			float2 uv114 = 0;
			float voroi114 = voronoi114( coords114, time114, id114, uv114, 0 );
			float4 lerpResult127 = lerp( screenColor130 , _PortalColor , saturate( ( temp_output_121_0 * voroi114 ) ));
			float time134 = 0.0;
			float2 coords134 = temp_output_116_0 * 8.62;
			float2 id134 = 0;
			float2 uv134 = 0;
			float voroi134 = voronoi134( coords134, time134, id134, uv134, 0 );
			float saferPower147 = max( saturate( ( temp_output_121_0 * voroi134 ) ) , 0.0001 );
			float4 lerpResult146 = lerp( lerpResult127 , _PortalDetailColor , saturate( pow( saferPower147 , 0.61 ) ));
			float temp_output_150_0 = ( 1.0 - pow( ( temp_output_118_0 / _CenterRange ) , _CenterPower ) );
			float4 lerpResult155 = lerp( lerpResult146 , _CenterColor , saturate( temp_output_150_0 ));
			o.Emission = saturate( lerpResult155 ).rgb;
			float grayscale158 = Luminance(lerpResult155.rgb);
			float CenterMask163 = temp_output_150_0;
			o.Alpha = saturate( ( (0.0 + (grayscale158 - 0.0) * (1.0 - 0.0) / (0.21 - 0.0)) + saturate( CenterMask163 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18711
135;473;848;546;-384.2111;433.8977;2.96979;True;False
Node;AmplifyShaderEditor.RangedFloatNode;8;-1548.53,229.0972;Inherit;False;Property;_TimeScale;TimeScale;1;0;Create;True;0;0;0;False;0;False;1;1.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1722.523,-31.12973;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;118;-1120.176,-337.2393;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-1191.823,-99.83775;Inherit;False;Property;_PortalRange;PortalRange;4;0;Create;True;0;0;0;False;0;False;0;0.308;0.3;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;7;-1383.884,141.1762;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;5;-1189.975,8.227394;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;122;-866.1945,-289.1721;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.31;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-1205.008,586.9822;Inherit;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;0;False;0;False;8.681004;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;4;-1621.774,-205.3219;Inherit;False;Property;_UVCenter;UVCenter;0;0;Create;True;0;0;0;False;0;False;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;135;-557.1189,479.0822;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;8.62;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;116;-820.7896,4.123341;Inherit;True;Twirl;-1;;3;90936742ac32db8449cd21ab6dd337c8;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;-0.12,-0.06;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;123;-626.9419,-302.8756;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.83;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;134;-329.8392,328.413;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.OneMinusNode;121;-432.5847,-312.863;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-559.793,157.9433;Inherit;False;Constant;_Float3;Float 3;8;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;114;-321.5847,2.294186;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-103.1202,260.3826;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;152;-719.1696,-929.1147;Inherit;False;Property;_CenterRange;CenterRange;7;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;131;-295.7209,-645.0898;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;148;131.8032,283.0693;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-110.1243,-16.79647;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;153;-430.7605,-738.0998;Inherit;False;Property;_CenterPower;CenterPower;6;0;Create;True;0;0;0;False;0;False;0;1.22;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;149;-457.7806,-998.2695;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.31;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;130;24.71471,-647.9134;Inherit;False;Global;_GrabScreen0;Grab Screen 0;5;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;128;-148.3609,-401.4069;Inherit;False;Property;_PortalColor;PortalColor;3;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;0,1,0.8734229,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;147;280.2949,269.7013;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;0.61;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;151;-218.528,-1011.973;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.83;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;132;135.8762,-49.70159;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;360.1898,-312.0403;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;138;457.4973,264.0753;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;141;446.14,545.4972;Inherit;False;Property;_PortalDetailColor;PortalDetailColor;5;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0.7023964,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;150;-24.17057,-1021.96;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;146;731.6099,199.2486;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;157;432.5273,-629.3824;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;156;708.7686,-694.2365;Inherit;False;Property;_CenterColor;CenterColor;8;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;155;1052.16,-243.7239;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;163;348.552,-969.4698;Inherit;False;CenterMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;158;1397.552,33.9342;Inherit;True;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;1604.005,336.7879;Inherit;True;163;CenterMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;166;1851.826,343.9698;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;162;1646.34,45.6975;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.21;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;165;2018.254,91.31901;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;145;1415.617,-239.1939;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1117.463,272.6812;Inherit;False;Property;_TwirlStrenght;TwirlStrenght;2;0;Create;True;0;0;0;False;0;False;27.14;39.56;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;167;2291.349,94.30887;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2469.982,-232.6181;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Portal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;118;0;2;0
WireConnection;7;0;8;0
WireConnection;5;0;2;0
WireConnection;5;2;7;0
WireConnection;122;0;118;0
WireConnection;122;1;129;0
WireConnection;116;1;5;0
WireConnection;116;2;4;0
WireConnection;116;3;117;0
WireConnection;123;0;122;0
WireConnection;134;0;116;0
WireConnection;134;2;135;0
WireConnection;121;0;123;0
WireConnection;114;0;116;0
WireConnection;114;2;115;0
WireConnection;137;0;121;0
WireConnection;137;1;134;0
WireConnection;148;0;137;0
WireConnection;125;0;121;0
WireConnection;125;1;114;0
WireConnection;149;0;118;0
WireConnection;149;1;152;0
WireConnection;130;0;131;0
WireConnection;147;0;148;0
WireConnection;151;0;149;0
WireConnection;151;1;153;0
WireConnection;132;0;125;0
WireConnection;127;0;130;0
WireConnection;127;1;128;0
WireConnection;127;2;132;0
WireConnection;138;0;147;0
WireConnection;150;0;151;0
WireConnection;146;0;127;0
WireConnection;146;1;141;0
WireConnection;146;2;138;0
WireConnection;157;0;150;0
WireConnection;155;0;146;0
WireConnection;155;1;156;0
WireConnection;155;2;157;0
WireConnection;163;0;150;0
WireConnection;158;0;155;0
WireConnection;166;0;164;0
WireConnection;162;0;158;0
WireConnection;165;0;162;0
WireConnection;165;1;166;0
WireConnection;145;0;155;0
WireConnection;167;0;165;0
WireConnection;0;2;145;0
WireConnection;0;9;167;0
ASEEND*/
//CHKSM=5C2EF38653815DA30F8FE644B0548DD85781E3D6