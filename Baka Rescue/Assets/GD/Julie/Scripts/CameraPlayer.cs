using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraPlayer : MonoBehaviour
{
    [SerializeField] private Camera _mainCamera = null;
    [SerializeField] private Transform _charac = null;
    private Transform _cameraTrans = null;

    // Start is called before the first frame update
    void Start()
    {
        _cameraTrans = _mainCamera.transform;
    }

    // Update is called once per frame
    void Update()
    {

        _cameraTrans.position = new Vector3(_charac.position.x, _cameraTrans.position.y, _cameraTrans.position.z);
    }
}
