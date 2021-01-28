// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color5 = IsGammaSpace() ? float4(1,0.07227322,0,0) : float4(1,0.006245438,0,0);
			float4 color9 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float2 temp_cast_0 = (_Time.y).xx;
			float2 panner10 = ( 1.0 * _Time.y * float2( 1,0 ) + temp_cast_0);
			float2 uv_TexCoord1 = i.uv_texcoord * panner10;
			float4 lerpResult4 = lerp( color5 , color9 , float4( step( uv_TexCoord1 , float2( 0.6,0 ) ), 0.0 , 0.0 ));
			o.Emission = lerpResult4.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
852;214;965;644;3018.42;573.3531;2.420294;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;11;-2222.145,-77.1928;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;10;-2038.295,34.14052;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1638.669,82.17522;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-1137.608,-349.9679;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;1,0.07227322,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;-1131.826,-182.7972;Inherit;False;Constant;_Color1;Color 1;0;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;2;-1016.429,88.32956;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.6,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;4;-687.7377,-145.1383;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;11;0
WireConnection;1;0;10;0
WireConnection;2;0;1;0
WireConnection;4;0;5;0
WireConnection;4;1;9;0
WireConnection;4;2;2;0
WireConnection;0;2;4;0
ASEEND*/
//CHKSM=04FCE618DA2AC87DDFE5189765ADC7D2F598C8A1