using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraPlayer : MonoBehaviour
{
    [SerializeField] private List<Transform> _targets;

    [SerializeField] private Vector3 _offset;

    private Vector3 _velocity;
    private Camera cam;

    [SerializeField] private float _smoothTime = 0.5f;

    [SerializeField] private float _minZoom = 40f;
    [SerializeField] private float _maxZoom = 10f;
    [SerializeField] private float _zoomLimiter = 50f;

    private void Start()
    {
        cam = GetComponent<Camera>();
        GameLoopManager.Instance.LateGameLoop += Loop;
    }
    private void OnDestroy()
    {
        GameLoopManager.Instance.LateGameLoop -= Loop;
    }

    void Loop()
        {
        if (_targets.Count == 0)
            return;

        Move();
        Zoom();
       }

    void Move ()
    {
        Vector3 centerPoint = GetCenterPoint();

        Vector3 newPosition = centerPoint + _offset;

        transform.position = Vector3.SmoothDamp(transform.position, newPosition, ref _velocity, _smoothTime);

    }

    void Zoom()
    {
        float newZoom = Mathf.Lerp(_maxZoom, _minZoom, GetGreatestDistance() / _zoomLimiter);
        cam.fieldOfView = Mathf.Lerp(cam.fieldOfView, newZoom, Time.deltaTime) ;
    }

    float GetGreatestDistance()
    {
        var bounds = new Bounds(_targets[0].position, Vector3.zero);
        for (int i =0; i < _targets.Count; i++)
        {
            bounds.Encapsulate(_targets[i].position);
        }
        return bounds.size.x;
    }

    Vector3 GetCenterPoint()
    {
        if(_targets.Count == 1)
        {
            return _targets[0].position;
        }

        var bounds = new Bounds(_targets[0].position, Vector3.zero);
            for(int i = 0; i < _targets.Count; i++) 
        {
            bounds.Encapsulate(_targets[i].position);
        }

        return bounds.center;
    }
}
