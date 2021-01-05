// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FuelUI"
{
	Properties
	{
		_ScrollSpeed("ScrollSpeed", Float) = 0.5
		_Texture0("Texture 0", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "black" {}
		_FloodOffset("FloodOffset", Float) = 0
		_Color0("Color 0", Color) = (1,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform sampler2D _Texture1;
		uniform float _ScrollSpeed;
		uniform float _FloodOffset;
		uniform float4 _Color0;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode15 = tex2D( _Texture0, uv_Texture0 );
			float mulTime42 = _Time.y * 0.25;
			float2 appendResult58 = (float2(_ScrollSpeed , 0.0));
			float2 temp_cast_0 = (_FloodOffset).xx;
			float2 uv_TexCoord49 = i.uv_texcoord + temp_cast_0;
			float2 panner57 = ( mulTime42 * appendResult58 + uv_TexCoord49);
			float4 tex2DNode48 = tex2D( _Texture1, panner57 );
			float lerpResult40 = lerp( tex2DNode15.r , tex2DNode48.r , tex2DNode15.g);
			float2 appendResult13 = (float2(0.0 , _ScrollSpeed));
			float2 panner12 = ( mulTime42 * appendResult13 + i.uv_texcoord);
			float temp_output_69_0 = ( ( tex2DNode15.g * tex2DNode48.r ) * tex2D( _Texture0, panner12 ).b );
			float4 temp_cast_1 = (( lerpResult40 + temp_output_69_0 )).xxxx;
			float4 lerpResult70 = lerp( temp_cast_1 , _Color0 , temp_output_69_0);
			o.Emission = lerpResult70.rgb;
			o.Alpha = tex2DNode15.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18711
0;73;889;655;1661.56;976.6908;3.622194;True;False
Node;AmplifyShaderEditor.RangedFloatNode;11;-2090.056,509.9002;Inherit;False;Property;_ScrollSpeed;ScrollSpeed;0;0;Create;True;0;0;0;False;0;False;0.5;-0.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1915.452,281.1559;Inherit;False;Property;_FloodOffset;FloodOffset;3;0;Create;True;0;0;0;False;0;False;0;0.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;42;-1625.868,662.6226;Inherit;False;1;0;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-1700.883,181.1435;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;58;-1637.266,368.8443;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;57;-1395.213,180.1626;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;44;-1075.968,-257.6353;Inherit;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;0;False;0;False;None;25bb5dd3cb4e0954ba8b8c76f05c62fd;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;47;-1418.531,-47.24537;Inherit;True;Property;_Texture1;Texture 1;2;0;Create;True;0;0;0;False;0;False;None;acdc1d00cdb532c40ba0dd36067b932f;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DynamicAppendNode;13;-1621.406,492.0977;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1279.884,666.059;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;12;-1016.88,460.5778;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;48;-1076.75,50.48056;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-742.8683,-261.7632;Inherit;True;Property;_MainInterface;MainInterface;2;0;Create;True;0;0;0;False;0;False;-1;None;25bb5dd3cb4e0954ba8b8c76f05c62fd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;39;-585.0002,289.2466;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;25bb5dd3cb4e0954ba8b8c76f05c62fd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-291.7111,57.84174;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-59.04739,268.4308;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;40;-211.3227,-232.397;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;66;198.186,-249.9582;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;85.82299,15.68836;Inherit;False;Property;_Color0;Color 0;4;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,1,0.2587609,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;67;429.5507,224.0802;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;70;457.3684,-42.62629;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;30;851.8245,-184.8884;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;FuelUI;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;49;1;50;0
WireConnection;58;0;11;0
WireConnection;57;0;49;0
WireConnection;57;2;58;0
WireConnection;57;1;42;0
WireConnection;13;1;11;0
WireConnection;12;0;20;0
WireConnection;12;2;13;0
WireConnection;12;1;42;0
WireConnection;48;0;47;0
WireConnection;48;1;57;0
WireConnection;15;0;44;0
WireConnection;39;0;44;0
WireConnection;39;1;12;0
WireConnection;62;0;15;2
WireConnection;62;1;48;1
WireConnection;69;0;62;0
WireConnection;69;1;39;3
WireConnection;40;0;15;1
WireConnection;40;1;48;1
WireConnection;40;2;15;2
WireConnection;66;0;40;0
WireConnection;66;1;69;0
WireConnection;67;0;15;4
WireConnection;70;0;66;0
WireConnection;70;1;71;0
WireConnection;70;2;69;0
WireConnection;30;2;70;0
WireConnection;30;9;67;0
ASEEND*/
//CHKSM=57201B45994F8E0757D46150A5C31A1A671333E7