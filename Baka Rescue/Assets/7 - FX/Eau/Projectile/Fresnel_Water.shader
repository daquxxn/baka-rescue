// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fresnel"
{
	Properties
	{
		_Bias("Bias", Range( 0 , 1)) = 0.215048
		_Scale("Scale", Range( 0 , 5)) = 1.479272
		_Power("Power", Range( 0 , 5)) = 2.126081
		_Color0("Color 0", Color) = (1,1,1,0)
		_Color1("Color 1", Color) = (0,0.8282521,1,0)
		_Mask("Mask", Range( 0 , 5)) = 1.039313
		_0("0", Range( 0 , 5)) = 1.039313
		_Height("Height", Range( 0 , 1)) = 0
		_Wave("Wave", 2D) = "white" {}
		_Noise("Noise", 2D) = "white" {}
		_U("U", Range( -5 , 5)) = 0.2591188
		_V("V", Range( -5 , 5)) = 0.3641046
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
		};

		uniform sampler2D _Wave;
		uniform float _U;
		uniform float _V;
		uniform sampler2D _Noise;
		uniform float4 _Noise_ST;
		uniform float _Mask;
		uniform float _0;
		uniform float _Height;
		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform float _Bias;
		uniform float _Scale;
		uniform float _Power;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 transform20 = mul(unity_WorldToObject,float4( float3(0,1,0) , 0.0 ));
			float4 appendResult34 = (float4(_U , _V , 0.0 , 0.0));
			float2 uv0_Noise = v.texcoord.xy * _Noise_ST.xy + _Noise_ST.zw;
			float2 panner27 = ( 0.5 * _Time.y * appendResult34.xy + uv0_Noise);
			float4 temp_output_35_0 = ( tex2Dlod( _Wave, float4( panner27, 0, 0.0) ) * tex2Dlod( _Noise, float4( panner27, 0, 0.0) ) );
			float4 lerpResult26 = lerp( float4( 0,0,0,0 ) , transform20 , temp_output_35_0);
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float clampResult14 = clamp( ( distance( ase_worldNormal.x , _Mask ) - _0 ) , 0.0 , 1.0 );
			float temp_output_16_0 = ( 1.0 - clampResult14 );
			float4 lerpResult21 = lerp( float4( 0,0,0,0 ) , lerpResult26 , temp_output_16_0);
			v.vertex.xyz += ( lerpResult21 * _Height ).xyz;
			float3 ase_vertexNormal = v.normal.xyz;
			v.normal = ase_vertexNormal;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV1 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1 = ( _Bias + _Scale * pow( 1.0 - fresnelNdotV1, _Power ) );
			float4 lerpResult8 = lerp( _Color0 , _Color1 , fresnelNode1);
			o.Emission = lerpResult8.rgb;
			float clampResult14 = clamp( ( distance( ase_worldNormal.x , _Mask ) - _0 ) , 0.0 , 1.0 );
			float temp_output_16_0 = ( 1.0 - clampResult14 );
			float4 appendResult34 = (float4(_U , _V , 0.0 , 0.0));
			float2 uv0_Noise = i.uv_texcoord * _Noise_ST.xy + _Noise_ST.zw;
			float2 panner27 = ( 0.5 * _Time.y * appendResult34.xy + uv0_Noise);
			float4 temp_output_35_0 = ( tex2D( _Wave, panner27 ) * tex2D( _Noise, panner27 ) );
			o.Alpha = ( fresnelNode1 * temp_output_16_0 * temp_output_35_0 ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
0;0;1920;1019;3309.402;-393.8146;1.076107;True;False
Node;AmplifyShaderEditor.RangedFloatNode;31;-2757.208,881.2073;Inherit;False;Property;_V;V;11;0;Create;True;0;0;False;0;0.3641046;0;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2756.332,789.108;Inherit;False;Property;_U;U;10;0;Create;True;0;0;False;0;0.2591188;0;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2161.661,1328.945;Inherit;True;Property;_Mask;Mask;5;0;Create;True;0;0;False;0;1.039313;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;9;-2202.03,1088.753;Inherit;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2434.732,671.1727;Inherit;False;0;25;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;34;-2407.152,798.466;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;27;-2119.002,705.5407;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1832.607,1450.47;Inherit;True;Property;_0;0;6;0;Create;True;0;0;False;0;1.039313;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;11;-1783.997,1158.808;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;-1779.641,688.6404;Inherit;True;Property;_Wave;Wave;8;0;Create;True;0;0;False;0;9789d23040cb1fb45ad60392430c3c15;9789d23040cb1fb45ad60392430c3c15;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-1778.911,889.4056;Inherit;True;Property;_Noise;Noise;9;0;Create;True;0;0;False;0;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;19;-1727.924,514.1142;Inherit;False;Constant;_Vector0;Vector 0;7;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-1505.422,1177.505;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;20;-1444.297,497.7793;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1417.512,693.1549;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;14;-1253.021,1156.939;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1539.722,181.5892;Inherit;False;Property;_Bias;Bias;0;0;Create;True;0;0;False;0;0.215048;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;26;-1007.848,646.9129;Inherit;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;16;-1095.972,1084.023;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1565.606,274.2364;Inherit;False;Property;_Scale;Scale;1;0;Create;True;0;0;False;0;1.479272;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1554.709,370.9709;Inherit;False;Property;_Power;Power;2;0;Create;True;0;0;False;0;2.126081;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-953.6916,1.421318;Inherit;False;Property;_Color1;Color 1;4;0;Create;True;0;0;False;0;0,0.8282521,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;1;-1038.338,233.3626;Inherit;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-542.861,716.2461;Inherit;True;Property;_Height;Height;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-956.3537,-174.2385;Inherit;False;Property;_Color0;Color 0;3;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;21;-510.3444,524.1339;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2536.568,972.4343;Inherit;False;Property;_Speed;Speed;12;0;Create;True;0;0;False;0;0.7822366;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-176.7356,542.6932;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;8;-559.7885,-79.75475;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-316.2719,265.3807;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;17;159.7679,712.2471;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;483.6182,-6.04523;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Fresnel;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;34;0;30;0
WireConnection;34;1;31;0
WireConnection;27;0;28;0
WireConnection;27;2;34;0
WireConnection;11;0;9;1
WireConnection;11;1;10;0
WireConnection;24;1;27;0
WireConnection;25;1;27;0
WireConnection;12;0;11;0
WireConnection;12;1;13;0
WireConnection;20;0;19;0
WireConnection;35;0;24;0
WireConnection;35;1;25;0
WireConnection;14;0;12;0
WireConnection;26;1;20;0
WireConnection;26;2;35;0
WireConnection;16;0;14;0
WireConnection;1;1;4;0
WireConnection;1;2;3;0
WireConnection;1;3;2;0
WireConnection;21;1;26;0
WireConnection;21;2;16;0
WireConnection;23;0;21;0
WireConnection;23;1;22;0
WireConnection;8;0;5;0
WireConnection;8;1;6;0
WireConnection;8;2;1;0
WireConnection;15;0;1;0
WireConnection;15;1;16;0
WireConnection;15;2;35;0
WireConnection;0;2;8;0
WireConnection;0;9;15;0
WireConnection;0;11;23;0
WireConnection;0;12;17;0
ASEEND*/
//CHKSM=46EC986E7F5C1F83D2091869F4D7F3FC954B1A61