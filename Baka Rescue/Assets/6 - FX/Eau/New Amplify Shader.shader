// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Water"
{
	Properties
	{
		_Direction_Vague("Direction_Vague", Vector) = (1,0,0,0)
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Stretch_Vague("Stretch_Vague", Vector) = (0.025,0.15,0,0)
		_Vitesse_Vague("Vitesse_Vague", Range( 0 , 1)) = 1
		_Taille_Vague("Taille_Vague", Range( 0 , 1)) = 1
		_Hauteur_Vague("Hauteur_Vague", Float) = 0.2
		_Couleur_Water("Couleur_Water", Color) = (0,0,0,0)
		_Top_Color("Top_Color", Color) = (0,0,0,0)
		_Float2("Float 2", Range( 0 , 10)) = 1
		_Distance_Edge("Distance_Edge", Range( 0 , 1)) = 0
		_Float1("Float 1", Range( 0 , 10)) = 1
		_Float0("Float 0", Range( 0 , 10)) = 1
		_Edge_power("Edge_power", Range( 0 , 1)) = 0
		_RefractAmount("Refract Amount", Range( 0 , 0.1)) = 0.1
		_Normal_Map("Normal_Map", 2D) = "white" {}
		_Normal_Speed("Normal_Speed", Range( 0 , 1)) = 1
		_tile_Normal("tile_Normal", Range( 0 , 1)) = 1
		_Strength_Normal("Strength_Normal", Range( 0 , 1)) = 1
		_Foam_Mer("Foam_Mer", 2D) = "white" {}
		_Edge_Foam_Tile("Edge_Foam_Tile", Range( 0 , 1)) = 1
		_Sea_Foam_Tile("Sea_Foam_Tile", Range( 0 , 1)) = 1
		_Masque_Foam("Masque_Foam", Range( 0 , 2)) = 2
		_Depth("Depth", Range( -4 , 0)) = -4
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
		};

		uniform float _Hauteur_Vague;
		uniform float _Vitesse_Vague;
		uniform float2 _Direction_Vague;
		uniform float2 _Stretch_Vague;
		uniform float _Taille_Vague;
		uniform sampler2D _Normal_Map;
		uniform float _Strength_Normal;
		uniform float _Normal_Speed;
		uniform float _Float0;
		uniform float _tile_Normal;
		uniform float4 _Couleur_Water;
		uniform float4 _Top_Color;
		uniform sampler2D _Foam_Mer;
		uniform float _Float2;
		uniform float _Sea_Foam_Tile;
		uniform float _Masque_Foam;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float _RefractAmount;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth;
		uniform float _Distance_Edge;
		uniform float _Float1;
		uniform float _Edge_Foam_Tile;
		uniform float _Edge_power;
		uniform float _EdgeLength;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


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


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float temp_output_10_0 = ( _Time.y * _Vitesse_Vague );
			float2 temp_cast_0 = (_Direction_Vague.x).xx;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float4 appendResult12 = (float4(ase_worldPos.x , ase_worldPos.z , 0.0 , 0.0));
			float4 WorldSpaceTile13 = appendResult12;
			float4 Tile_Vague_UVs24 = ( ( WorldSpaceTile13 * float4( _Stretch_Vague, 0.0 , 0.0 ) ) * _Taille_Vague );
			float2 panner3 = ( temp_output_10_0 * temp_cast_0 + Tile_Vague_UVs24.xy);
			float simplePerlin2D1 = snoise( panner3 );
			simplePerlin2D1 = simplePerlin2D1*0.5 + 0.5;
			float2 temp_cast_3 = (_Direction_Vague.x).xx;
			float2 panner26 = ( temp_output_10_0 * temp_cast_3 + ( Tile_Vague_UVs24 * float4( 0.1,0.1,0,0 ) ).xy);
			float simplePerlin2D27 = snoise( panner26 );
			simplePerlin2D27 = simplePerlin2D27*0.5 + 0.5;
			float Paterne_Vague31 = ( simplePerlin2D1 + simplePerlin2D27 );
			float3 Hauteur_Vague35 = ( ( float3(0,1,0) * _Hauteur_Vague ) * Paterne_Vague31 );
			v.vertex.xyz += Hauteur_Vague35;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float4 appendResult12 = (float4(ase_worldPos.x , ase_worldPos.z , 0.0 , 0.0));
			float4 WorldSpaceTile13 = appendResult12;
			float4 temp_output_80_0 = ( WorldSpaceTile13 / _Float0 );
			float2 panner67 = ( 1.0 * _Time.y * ( float2( 1,0 ) * _Normal_Speed ) + ( temp_output_80_0 * _tile_Normal ).xy);
			float2 panner68 = ( 1.0 * _Time.y * ( float2( -1,0 ) * ( _Normal_Speed * 3.0 ) ) + ( temp_output_80_0 * ( _tile_Normal * 5.0 ) ).xy);
			float3 Normals77 = BlendNormals( UnpackScaleNormal( tex2D( _Normal_Map, panner67 ), _Strength_Normal ) , UnpackScaleNormal( tex2D( _Normal_Map, panner68 ), _Strength_Normal ) );
			o.Normal = Normals77;
			float2 panner101 = ( 1.0 * _Time.y * float2( 0.04,-0.03 ) + ( WorldSpaceTile13 * _Masque_Foam ).xy);
			float simplePerlin2D100 = snoise( panner101 );
			simplePerlin2D100 = simplePerlin2D100*0.5 + 0.5;
			float4 clampResult108 = clamp( ( tex2D( _Foam_Mer, ( ( WorldSpaceTile13 / _Float2 ) * _Sea_Foam_Tile ).xy ) * simplePerlin2D100 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 Foam_Mer97 = clampResult108;
			float temp_output_10_0 = ( _Time.y * _Vitesse_Vague );
			float2 temp_cast_4 = (_Direction_Vague.x).xx;
			float4 Tile_Vague_UVs24 = ( ( WorldSpaceTile13 * float4( _Stretch_Vague, 0.0 , 0.0 ) ) * _Taille_Vague );
			float2 panner3 = ( temp_output_10_0 * temp_cast_4 + Tile_Vague_UVs24.xy);
			float simplePerlin2D1 = snoise( panner3 );
			simplePerlin2D1 = simplePerlin2D1*0.5 + 0.5;
			float2 temp_cast_7 = (_Direction_Vague.x).xx;
			float2 panner26 = ( temp_output_10_0 * temp_cast_7 + ( Tile_Vague_UVs24 * float4( 0.1,0.1,0,0 ) ).xy);
			float simplePerlin2D27 = snoise( panner26 );
			simplePerlin2D27 = simplePerlin2D27*0.5 + 0.5;
			float Paterne_Vague31 = ( simplePerlin2D1 + simplePerlin2D27 );
			float clampResult46 = clamp( Paterne_Vague31 , 0.0 , 1.0 );
			float4 lerpResult45 = lerp( _Couleur_Water , ( _Top_Color + Foam_Mer97 ) , clampResult46);
			float4 Albedo47 = lerpResult45;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 screenColor116 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float3( (ase_grabScreenPosNorm).xy ,  0.0 ) + ( _RefractAmount * Normals77 ) ).xy);
			float4 clampResult117 = clamp( screenColor116 , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 Refraction118 = clampResult117;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth121 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth121 = abs( ( screenDepth121 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Depth ) );
			float clampResult123 = clamp( ( 1.0 - distanceDepth121 ) , 0.0 , 1.0 );
			float Detph124 = clampResult123;
			float4 lerpResult126 = lerp( Albedo47 , Refraction118 , Detph124);
			o.Albedo = lerpResult126.rgb;
			float screenDepth50 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth50 = abs( ( screenDepth50 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Distance_Edge ) );
			float4 clampResult57 = clamp( ( ( ( 1.0 - distanceDepth50 ) + tex2D( _Foam_Mer, ( ( WorldSpaceTile13 / _Float1 ) * _Edge_Foam_Tile ).xy ) ) * _Edge_power ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 Edge55 = clampResult57;
			o.Emission = Edge55.rgb;
			o.Smoothness = 0.9;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
58;78;1434;611;5396.442;3687.892;4.758895;True;False
Node;AmplifyShaderEditor.CommentaryNode;14;-4916.955,-815.2796;Inherit;False;863.2007;295.7115;World Space UVs;3;11;12;13;World Space UVs;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;11;-4866.954,-765.2798;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;12;-4570.75,-738.7233;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;37;-5204.587,-346.8739;Inherit;False;2441.956;595.909;Comment;11;22;23;33;35;32;15;18;17;20;19;24;UVs_Hauteur_Vagues;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-4325.756,-749.5684;Inherit;True;WorldSpaceTile;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;78;-3205.061,-2786.011;Inherit;False;3360.3;1586.217;Comment;21;61;62;63;59;66;64;60;68;67;70;71;69;73;74;72;75;40;76;77;80;81;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;-5154.587,-259.5361;Inherit;True;13;WorldSpaceTile;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector2Node;18;-5123.114,-63.23656;Inherit;True;Property;_Stretch_Vague;Stretch_Vague;6;0;Create;True;0;0;False;0;0.025,0.15;0.025,0.15;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;61;-3194.029,-2690.68;Inherit;True;13;WorldSpaceTile;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-3160.737,-2232.087;Inherit;True;Property;_Float0;Float 0;15;0;Create;True;0;0;False;0;1;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-2321.994,-2294.665;Inherit;True;Property;_Normal_Speed;Normal_Speed;19;0;Create;True;0;0;False;0;1;0.01;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-4807.436,-250.6804;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-4778.289,-11.33092;Inherit;True;Property;_Taille_Vague;Taille_Vague;8;0;Create;True;0;0;False;0;1;0.22;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-2921.961,-2120.534;Inherit;True;Property;_tile_Normal;tile_Normal;20;0;Create;True;0;0;False;0;1;0.02;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-2709.64,-1817.093;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-2083.657,-2271.393;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;69;-2353.869,-2559.985;Inherit;True;Constant;_Direction_Panner;Direction_Panner;8;0;Create;True;0;0;False;0;1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;70;-2253.827,-1503.794;Inherit;True;Constant;_Direction_Panner02;Direction_Panner02;8;0;Create;True;0;0;False;0;-1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;80;-2940.586,-2465.06;Inherit;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-4547.436,-250.6804;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-5630.092,-1803.127;Inherit;True;Property;_Masque_Foam;Masque_Foam;25;0;Create;True;0;0;False;0;2;-0.03;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-5711.3,-2272.767;Inherit;True;Property;_Float2;Float 2;12;0;Create;True;0;0;False;0;1;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-2021.335,-2541.277;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-2649.221,-2415.441;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-1852.042,-1673.982;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;38;-5214.111,378.9921;Inherit;False;1931.972;1289.741;Comment;13;9;30;7;10;5;28;25;3;26;27;1;29;31;Paterne_Vagues;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-4288.375,-254.1794;Inherit;True;Tile_Vague_UVs;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-5761.446,-2497.297;Inherit;True;13;WorldSpaceTile;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-2479.156,-1807.488;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-5324.642,-2125.877;Inherit;True;Property;_Sea_Foam_Tile;Sea_Foam_Tile;24;0;Create;True;0;0;False;0;1;81.35;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;7;-5151.312,931.9419;Inherit;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;90;-5798.117,-3360.833;Inherit;False;1798.742;810.3059;Comment;8;83;89;85;82;86;87;84;88;Mousse_Foam;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;93;-5335.746,-2427.633;Inherit;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-1284.807,-2100.683;Inherit;True;Property;_Strength_Normal;Strength_Normal;21;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;67;-1608.208,-2644.33;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;68;-1492.168,-1766.114;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-5366.677,-1827.385;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-5164.111,1184.741;Inherit;True;Property;_Vitesse_Vague;Vitesse_Vague;7;0;Create;True;0;0;False;0;1;0.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;59;-2417.817,-2052.163;Inherit;True;Property;_Normal_Map;Normal_Map;18;0;Create;True;0;0;False;0;None;None;True;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;-5156.155,1438.733;Inherit;True;24;Tile_Vague_UVs;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-4906.103,428.9921;Inherit;True;24;Tile_Vague_UVs;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;101;-5055.992,-1828.308;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,-0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;40;-969.114,-2261.426;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;None;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-4898.72,988.9384;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-4888.372,1246.71;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0.1,0.1,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector2Node;5;-4904.911,698.3421;Inherit;True;Property;_Direction_Vague;Direction_Vague;0;0;Create;True;0;0;False;0;1,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;60;-946.3049,-1818.424;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;None;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-4930.308,-2338.874;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;82;-4965.472,-3224.289;Inherit;True;Property;_Foam_Mer;Foam_Mer;22;0;Create;True;0;0;False;0;None;d01457b88b1c5174ea4235d140b5fab8;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;91;-4472.939,-2416.801;Inherit;True;Property;_TextureSample3;Texture Sample 3;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;3;-4591.309,435.9416;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;26;-4533.334,779.0724;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendNormalsNode;75;-432.339,-1996.592;Inherit;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;100;-4764.649,-1848.062;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;120;-2433.912,-3702.017;Inherit;False;1692.54;694.2092;R;9;114;110;112;111;113;115;116;117;118;Refraction;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-4174.725,-2142.902;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-87.76273,-2005.565;Float;True;Normals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1;-4200.91,450.3417;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;27;-4193.916,764.4063;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-5697.971,-2961.019;Inherit;True;Property;_Float1;Float 1;14;0;Create;True;0;0;False;0;1;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-5748.117,-3185.549;Inherit;True;13;WorldSpaceTile;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;58;-5202.958,-3972.111;Inherit;False;2148.994;429.1331;Comment;7;54;55;57;53;52;50;51;Mousses;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-5151.995,-3841.844;Inherit;True;Property;_Distance_Edge;Distance_Edge;13;0;Create;True;0;0;False;0;0;1.94;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-5315.174,-2812.571;Inherit;True;Property;_Edge_Foam_Tile;Edge_Foam_Tile;23;0;Create;True;0;0;False;0;1;-0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;110;-2383.912,-3652.017;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;112;-2346.651,-3473.107;Inherit;True;Property;_RefractAmount;Refract Amount;17;0;Create;True;0;0;False;0;0.1;0.1;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-3893.572,622.8788;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;114;-2344.051,-3237.807;Inherit;True;77;Normals;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;87;-5322.417,-3115.885;Inherit;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ClampOpNode;108;-3867.002,-2119.315;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;129;-1909.41,-4726.574;Inherit;False;1406.088;350.9302;Comment;5;122;121;128;123;124;Detph;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-1859.41,-4660.168;Inherit;True;Property;_Depth;Depth;26;0;Create;True;0;0;False;0;-4;-19.8;-4;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;111;-2051.551,-3651.207;Inherit;True;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-3554.139,653.8162;Inherit;True;Paterne_Vague;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;49;-4155.947,-5371.554;Inherit;False;1656.082;1153.94;Comment;8;41;47;45;42;46;44;98;99;Couleur;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;97;-3620.969,-2402.905;Inherit;True;Foam_Mer;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;50;-4894.554,-3908.725;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-4916.979,-3027.126;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-2022.951,-3417.206;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;83;-4691.408,-3237.671;Inherit;True;Property;_TextureSample2;Texture Sample 2;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;121;-1602.527,-4676.574;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;-4075.845,-4916.103;Inherit;True;97;Foam_Mer;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;52;-4618.889,-3909.325;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;42;-4104.831,-5134.611;Inherit;False;Property;_Top_Color;Top_Color;11;0;Create;True;0;0;False;0;0,0,0,0;0.4039216,0.7843137,0.7413894,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;115;-1703.151,-3519.907;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-4023.111,-4616.792;Inherit;True;31;Paterne_Vague;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-4303.01,-3306.789;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-4266.654,-3869.163;Inherit;True;Property;_Edge_power;Edge_power;16;0;Create;True;0;0;False;0;0;0.58;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;41;-4112.497,-5319.187;Inherit;False;Property;_Couleur_Water;Couleur_Water;10;0;Create;True;0;0;False;0;0,0,0,0;0.3985849,0.5,0.4970513,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;116;-1441.85,-3525.105;Inherit;False;Global;_GrabScreen0;Grab Screen 0;15;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;98;-3749.236,-5027.338;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;22;-3958.387,-296.8739;Inherit;True;Constant;_Up_Vague;Up_Vague;3;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;32;-3969.14,-8.964903;Inherit;True;Property;_Hauteur_Vague;Hauteur_Vague;9;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;128;-1266.17,-4649.868;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;46;-3712.899,-4623.583;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-3851.881,-3881.562;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;117;-1241.372,-3518.005;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;123;-979.0162,-4649.157;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;45;-3456.088,-5146.778;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-3712.189,-214.6681;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;47;-3097.876,-5126.398;Inherit;True;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-3283.935,-69.41138;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;118;-984.371,-3521.005;Float;True;Refraction;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;57;-3600.431,-3816.492;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-746.3228,-4633.644;Float;True;Detph;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;119;-618.7766,-718.533;Inherit;True;118;Refraction;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-3291.216,-3898.388;Float;True;Edge;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;-618.7043,-527.9677;Inherit;True;124;Detph;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;-3034.631,-71.59752;Float;True;Hauteur_Vague;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;-621.4734,-902.2992;Inherit;True;47;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-706.5963,1033.452;Inherit;True;Constant;_Max_Tesselation;Max_Tesselation;17;0;Create;True;0;0;False;0;80;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;-615.0445,-319.6261;Inherit;True;77;Normals;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-622.1428,-103.0108;Inherit;True;55;Edge;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-617.2422,99.07157;Inherit;True;Constant;_Smoothness;Smoothness;3;0;Create;True;0;0;False;0;0.9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-634.7359,331.1146;Inherit;True;35;Hauteur_Vague;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceBasedTessNode;130;-439.7451,726.1627;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;131;-703.1138,589.676;Inherit;True;Property;_Tesselation;Tesselation;27;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-717.0375,810.6936;Inherit;True;Constant;_Min_Tesselation;Min_Tesselation;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;126;-273.2251,-674.1373;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;6;ASEMaterialInspector;0;0;Standard;Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;11;1
WireConnection;12;1;11;3
WireConnection;13;0;12;0
WireConnection;17;0;15;0
WireConnection;17;1;18;0
WireConnection;64;0;63;0
WireConnection;73;0;72;0
WireConnection;80;0;61;0
WireConnection;80;1;81;0
WireConnection;19;0;17;0
WireConnection;19;1;20;0
WireConnection;71;0;69;0
WireConnection;71;1;72;0
WireConnection;62;0;80;0
WireConnection;62;1;63;0
WireConnection;74;0;70;0
WireConnection;74;1;73;0
WireConnection;24;0;19;0
WireConnection;66;0;80;0
WireConnection;66;1;64;0
WireConnection;93;0;96;0
WireConnection;93;1;92;0
WireConnection;67;0;62;0
WireConnection;67;2;71;0
WireConnection;68;0;66;0
WireConnection;68;2;74;0
WireConnection;103;0;96;0
WireConnection;103;1;104;0
WireConnection;101;0;103;0
WireConnection;40;0;59;0
WireConnection;40;1;67;0
WireConnection;40;5;76;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;28;0;30;0
WireConnection;60;0;59;0
WireConnection;60;1;68;0
WireConnection;60;5;76;0
WireConnection;94;0;93;0
WireConnection;94;1;95;0
WireConnection;91;0;82;0
WireConnection;91;1;94;0
WireConnection;3;0;25;0
WireConnection;3;2;5;1
WireConnection;3;1;10;0
WireConnection;26;0;28;0
WireConnection;26;2;5;1
WireConnection;26;1;10;0
WireConnection;75;0;40;0
WireConnection;75;1;60;0
WireConnection;100;0;101;0
WireConnection;107;0;91;0
WireConnection;107;1;100;0
WireConnection;77;0;75;0
WireConnection;1;0;3;0
WireConnection;27;0;26;0
WireConnection;29;0;1;0
WireConnection;29;1;27;0
WireConnection;87;0;84;0
WireConnection;87;1;88;0
WireConnection;108;0;107;0
WireConnection;111;0;110;0
WireConnection;31;0;29;0
WireConnection;97;0;108;0
WireConnection;50;0;51;0
WireConnection;85;0;87;0
WireConnection;85;1;86;0
WireConnection;113;0;112;0
WireConnection;113;1;114;0
WireConnection;83;0;82;0
WireConnection;83;1;85;0
WireConnection;121;0;122;0
WireConnection;52;0;50;0
WireConnection;115;0;111;0
WireConnection;115;1;113;0
WireConnection;89;0;52;0
WireConnection;89;1;83;0
WireConnection;116;0;115;0
WireConnection;98;0;42;0
WireConnection;98;1;99;0
WireConnection;128;0;121;0
WireConnection;46;0;44;0
WireConnection;53;0;89;0
WireConnection;53;1;54;0
WireConnection;117;0;116;0
WireConnection;123;0;128;0
WireConnection;45;0;41;0
WireConnection;45;1;98;0
WireConnection;45;2;46;0
WireConnection;23;0;22;0
WireConnection;23;1;32;0
WireConnection;47;0;45;0
WireConnection;33;0;23;0
WireConnection;33;1;31;0
WireConnection;118;0;117;0
WireConnection;57;0;53;0
WireConnection;124;0;123;0
WireConnection;55;0;57;0
WireConnection;35;0;33;0
WireConnection;130;0;131;0
WireConnection;130;1;132;0
WireConnection;130;2;133;0
WireConnection;126;0;48;0
WireConnection;126;1;119;0
WireConnection;126;2;127;0
WireConnection;0;0;126;0
WireConnection;0;1;79;0
WireConnection;0;2;56;0
WireConnection;0;4;39;0
WireConnection;0;11;36;0
ASEEND*/
//CHKSM=AE260FF835EB0BBD3B85A185439337404BCAD312